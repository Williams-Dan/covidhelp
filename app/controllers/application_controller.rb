# frozen_string_literal: true

require './config/environment'

#:nodoc:
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :welcome
  end

  get '/login' do
    erb :login
  end

  get '/register' do
    erb :register
  end
end
