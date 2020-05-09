# frozen_string_literal: true

require './config/environment'

#:nodoc:
class UserController < Sinatra::Base
  set :session_secret, ENV['SESSION_SECRET']
  enable :sessions

  configure do
    set :public_folder, 'public'
    set :views, 'app/views/users'
    set :erb, layout_options: { views: 'app/views' }
  end

  get '/login' do
    @flashes = session.delete(:flashes) || []
    erb :login
  end

  get '/register' do
    @flashes = session.delete(:flashes) || []
    erb :register
  end

  post '/register' do
    @flashes = session.delete(:flashes) || []

    # Validate we have all required args
    %w[name email password].each do |required|
      next unless params[required].empty?

      @flashes.push({
                      error: true,
                      msg: "#{required.capitalize} must be provided"
                    })
    end

    # Check passwords match
    if params[:password] != params[:passwordConfirm]
      @flashes.push({ error: true, msg: 'Passwords do not match' })
    end

    # If we have any flash messages then we have an error
    return erb :register unless @flashes.empty?

    User.create!(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )

    session[:flashes] = [{ success: true, msg: 'Successfully Created!' }]
    redirect to('/')
  end
end
