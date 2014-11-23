# config valid only for Capistrano 3.1
lock '3.2.1'

set :rails_env, "production"
set :application, 'joelbook'
set :repo_url, 'https://github.com/freeman286/joelbook.git'

set :deploy_to, '/home/joelmayer'

#set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

require 'capistrano-db-tasks'

# If you want to import assets, you can change default asset dir (default = system)
# This directory must be in your shared directory on the server
set :assets_dir, %w(public/assets public/att)
set :local_assets_dir, %w(public/assets public/att)

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd joelbook; thin stop"
      execute "cd joelbook; thin start -d -e production"
      execute "cd joelbook/realtime; kill -9 pid"
      execute "cd joelbook/realtime; nohup node realtime-server.js"
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end