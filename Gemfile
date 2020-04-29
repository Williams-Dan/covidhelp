# frozen_string_literal: true

source 'http://rubygems.org'

ruby '2.7.0'

gem 'activerecord', '~> 4.2', '>= 4.2.6', require: 'active_record'
gem 'bcrypt'
gem 'bigdecimal', '~> 1.4'
gem 'pry'
gem 'rake'
gem 'require_all'
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
  gem 'mysql2', '>= 0.4.4'
  gem 'rubocop', require: false
  gem 'shotgun'
  gem 'corneal', '~> 0.1.5', require: false
end
