# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.13.0'

after 'deploy:updating', 'db:migrate'

set :application, 'covidhelp'
set :repo_url, 'git@github.com:Williams-Dan/covidhelp.git'

set :deploy_to, "/home/deploy/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'vendor/bundle', '.bundle'

# Only keep the last 5 releases to save disk space
set :keep_releases, 5


namespace :db do
  task :migrate do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:migrate'
        end
      end
    end
  end
end