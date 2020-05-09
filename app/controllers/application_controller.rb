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
end
