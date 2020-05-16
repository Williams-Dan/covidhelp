# frozen_string_literal: true

require './config/environment'

#:nodoc:
class UserController < ApplicationController
  get '/login' do
    @flashes = session.delete(:flashes) || []
    erb :'/users/login'
  end

  get '/register' do
    @flashes = session.delete(:flashes) || []
    erb :'/users/register'
  end

  post '/register' do
    @flashes = session.delete(:flashes) || []

    # Validate we have all required args
    %w[name email password passwordConfirm].each do |required|
      next if params[required]

      @flashes.push({
                      error: true,
                      msg: "#{required.capitalize} must be provided"
                    })
    end

    # Check passwords match
    if params[:password] != params[:passwordConfirm]
      @flashes.push({ error: true, msg: 'Passwords do not match' })
    end

    # Check the email address is valid
    if params[:email] !~ URI::MailTo::EMAIL_REGEXP
      @flashes.push({ error: true, msg: 'Not a valid email address' })
    end

    # If we have any flash messages then we have an error
    return erb :'/users/register' unless @flashes.empty?

    User.create!(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )

    # TODO: send confirm email
    session[:flashes] = [{ success: true, msg: 'Successfully Created!' }]
    redirect to('/')
  end
end
