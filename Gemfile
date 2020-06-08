# frozen_string_literal: true

source 'http://rubygems.org'

ruby '2.7.0'

gem 'activerecord', '~> 4.2', '>= 4.2.6', require: 'active_record'
gem 'bcrypt'
gem 'bigdecimal', '~> 1.4'
gem 'dotenv'
gem 'jwt'
gem 'mysql2', '>= 0.4.4'
gem 'pry'
gem 'rake'
gem 'require_all'
gem 'sendgrid-ruby'
gem 'sinatra'
gem 'sinatra-activerecord', require: 'sinatra/activerecord'
gem 'thin'
gem 'tux'

group :test do
  gem 'capybara'
  gem 'database_cleaner', '~> 1.8', '>= 1.8.4'
  gem 'rack-test'
  gem 'rspec'
  gem 'sqlite3', '~> 1.3.6'
end

group :development do
  gem 'capistrano', '~> 3.11'
  gem 'capistrano-bundler', require: false
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
  gem 'readapt', '~> 1.0'
  gem 'rubocop', require: false
  gem 'shotgun'
end
