# frozen_string_literal: true

ENV['SINATRA_ENV'] ||= 'development'

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc 'Runs the rspec tests in the codebase'
task :test do
  raise "Missing gem, run: 'rake install'" unless sh "gem list '^rspec$' -i"

  ENV['SINATRA_ENV'] = 'test'
  sh 'rspec'
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

  ENV['SINATRA_ENV'] = 'development'
  sh 'shotgun'
end

desc 'TODO'
task deploy: %i[install test lint] do
  # todo
end
