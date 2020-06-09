# frozen_string_literal: true

require './config/environment'
require './lib/json_web_token'

#:nodoc:
class UserController < ApplicationController
  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    # Validate we have all required args
    validate_args(%w[email password])

    user = User.find_by(email: params['email'])

    if !user || (user.password != params['password'])
      @flashes.push('Email or password is incorrect', :error)
    end

    # If we have any flash messages then we have an error
    return erb :'/users/login' unless @flashes.empty?

    session[:user_id] = user.id
    @flashes.push('Logged in!', :success)
    redirect to('/')
  end

  get '/register' do
    erb :'/users/register'
  end

  post '/register' do
    # Validate we have all required args
    validate_args(%w[name email password])

    # Check passwords match
    if params[:password] != params[:passwordConfirm]
      @flashes.push('Passwords do not match', :error)
    end

    if User.find_by(email: params[:email])
      @flashes.push('Account already exists, please log in')
      redirect to('/login')
    end

    # Check the email address is valid
    if !params[:email]&.empty? && params[:email] !~ URI::MailTo::EMAIL_REGEXP
      @flashes.push('Not a valid email address', :error)
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
    @flashes.push('Successfully Created!', :success)
    redirect to('/')
  end

  get '/verify' do
    # Validate we have all required args
    validate_args(%w[token])

    if params[:token]
      if User.verify_from_token(params[:token])
        @flashes.push('Your email has been verified', :success)
      else
        @flashes.push('Something went wrong...', :error)
      end
    end

    redirect to('/')
  end
end
