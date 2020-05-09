# frozen_string_literal: true

require './config/environment'

#:nodoc:
class UserController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views/users'
    set :erb, :layout_options => { :views => 'app/views' }
  end

  get '/login' do
    erb :login
  end

  get '/register' do
    erb :register
  end
end

