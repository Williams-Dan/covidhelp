# frozen_string_literal: true

ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "spec/db/#{ENV['SINATRA_ENV']}.dat"
)

require './app/controllers/application_controller'
require_all 'app'
