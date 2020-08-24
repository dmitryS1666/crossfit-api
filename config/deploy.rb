require 'whenever/capistrano'
set :application, 'bumgild-backend-api'
set :repo_url, 'git@gitlab.com:yesit/bumgild-backend-api.git'
set :deploy_to, '/var/www/bumgild-backend-api'
set :use_sudo, true
set :branch, 'master'
set :linked_dirs,
    fetch(:linked_dirs, []).push(
      'log',
      'tmp/pids',
      'tmp/cache',
      'tmp/sockets',
      'vendor/bundle',
      'public'
    )

set :rvm_type, :user
set :rvm_ruby_version, '2.5.1'
set :rvm_custom_path, '/usr/share/rvm/'

set :linked_files, %w[config/master.key]

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# set :whenever_environment, defer { stage }
# set :whenever_command, 'bundle exec whenever'
namespace :deploy do
  desc 'reload the database with seed data'
  task :seed do
    on roles(:all) do
      within current_path do
        execute :bundle, :exec, 'rails', 'db:seed', 'RAILS_ENV=production'
      end
    end
  end
end
