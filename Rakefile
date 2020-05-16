# frozen_string_literal: true

ENV['APP_ENV'] ||= 'development'

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc 'Runs the rspec tests in the codebase'
task :test do
  raise "Missing gem, run: 'rake install'" unless sh "gem list '^rspec$' -i"

  ENV['APP_ENV'] = 'test'
  sh 'rspec'
end

desc 'install missing ubuntu packages'
task: :install do
  sh 'apt-get install libmysqlclient-dev'
end

desc 'Simple a wrapper for bundle install'
task :install do
  sh 'bundle install'
end

desc 'Runs rubocop over the code base and tries to correct what it can'
task :lint do
  raise "Missing gem, run: 'rake install'" unless sh "gem list '^rubocop$' -i"

  sh 'rubocop -a'
end

desc 'Runs the app in an embeded server for development and testing purposes'
task run: :lint do
  raise "Missing gem, run: 'rake install'" unless sh "gem list '^shotgun$' -i"

  ENV['APP_ENV'] = 'development'
  sh 'shotgun'
end

desc 'HOST should be set and the ssh key should be setup on deploying machine'
task :deploy do
  unless sh "gem list '^capistrano$' -i"
    raise "Missing gem, run: 'rake install'"
  end
  raise 'Run with HOST set to you servers IP address' unless ENV['HOST']

  sh 'cap production deploy'
end
