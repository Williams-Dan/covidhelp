# frozen_string_literal: true

ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: "spec/db/#{ENV['SINATRA_ENV']}.dat"
)

if ENV['SINATRA_ENV'] == 'development'
  ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    encoding: 'utf8mb4',
    collation: 'utf8mb4_bin',
    username: 'covid-help-app',
    password: 'password1!',
    host: '127.0.0.1',
    database: 'covidhelp'
  )
elsif ENV['SINATRA_ENV'] == 'production'
  ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    encoding: 'utf8mb4',
    collation: 'utf8mb4_bin',
    username: ENV['DB_USERNAME'],
    password: ENV['DB_PASSWORD'],
    host: ENV['DB_HOST'],
    database: ENV['DB_NAME']
  )
elsif ENV['SINATRA_ENV'] == 'test'
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: "spec/db/#{ENV['SINATRA_ENV']}.dat"
  )
else
  raise 'No enviroment set'
end

require './app/controllers/application_controller'
require_all 'app'
