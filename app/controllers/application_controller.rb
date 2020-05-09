# frozen_string_literal: true

require './config/environment'

require 'dotenv'
Dotenv.load

#:nodoc:
class ApplicationController < Sinatra::Base
  set :session_secret, ENV['SESSION_SECRET']
  enable :sessions

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @flashes = session.delete(:flashes) || []
    erb :welcome
  end
end
