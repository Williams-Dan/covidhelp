# frozen_string_literal: true

require './config/environment'
require './lib/flashes'

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

  # Before each route load our Flash handler class
  before do
    @flashes = Flashes.new(session)
  end

  get '/' do
    erb :welcome
  end

  def validate_args(required)
    # Validate we have all required args
    required.each do |arg|
      next unless !params[arg] || params[arg].empty?

      @flashes.push("#{arg.capitalize} must be provided", :error)
    end
  end
end
