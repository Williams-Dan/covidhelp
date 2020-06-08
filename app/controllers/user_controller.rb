# frozen_string_literal: true

require './config/environment'
require './lib/json_web_token'

#:nodoc:
class UserController < ApplicationController
  get '/login' do
    @flashes = session.delete(:flashes) || []
    erb :'/users/login'
  end

  post '/login' do
    @flashes = session.delete(:flashes) || []

    # Validate we have all required args
    validate_args(%w[email password])

    user = User.find_by(email: params['email'])

    if !user || (user.password != params['password'])
      @flashes.push({ error: true, msg: 'Email or password is incorrect' })
    end

    # If we have any flash messages then we have an error
    return erb :'/users/login' unless @flashes.empty?

    session[:user_id] = user.id
    session[:flashes] = [{ success: true, msg: 'Logged in!' }]
    redirect to('/')
  end

  get '/register' do
    @flashes = session.delete(:flashes) || []
    erb :'/users/register'
  end

  post '/register' do
    @flashes = session.delete(:flashes) || []

    # Validate we have all required args
    validate_args(%w[name email password])

    # Check passwords match
    if params[:password] != params[:passwordConfirm]
      @flashes.push({ error: true, msg: 'Passwords do not match' })
    end

    if User.find_by(email: params[:email])
      session[:flashes] = [{ msg: 'Account already exists, please log in' }]
      redirect to('/login')
    end

    # Check the email address is valid
    if !params[:email]&.empty? && params[:email] !~ URI::MailTo::EMAIL_REGEXP
      @flashes.push({ error: true, msg: 'Not a valid email address' })
    end

    # If we have any flash messages then we have an error
    return erb :'/users/register' unless @flashes.empty?

    user = User.create!(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )

    user.send_verify_email

    session[:user_id] = user.id
    session[:flashes] = [{ success: true, msg: 'Successfully Created!' }]
    redirect to('/')
  end

  get '/verify' do
    @flashes = session.delete(:flashes) || []

    # Validate we have all required args
    validate_args(%w[token])

    if params[:token]
      if User.verify_from_token(params[:token])
        @flashes.push({ success: true, msg: 'Your email has been verified' })
      else
        @flashes.push({ error: true, msg: 'Something went wrong...' })
      end
    end

    session[:flashes] = @flashes
    redirect to('/')
  end
end
