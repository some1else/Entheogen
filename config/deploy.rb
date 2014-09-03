require "bundler/capistrano"
# require 'sidekiq/capistrano'

server "tesla", :web, :app, :db, primary: true

set :application, "entheogen_rails"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@gitlab.com:srdjan.prodanovic/entheogen.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases



namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    # sudo "ln -nfs #{current_path}/config/sidekiq_init.sh /etc/init.d/sidekiq_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    # run "ln -nfs #{shared_path}/config/initializers/stripe.rb #{release_path}/config/initializers/stripe.rb"
    # run "ln -nfs #{shared_path}/config/initializers/filepicker.rb #{release_path}/config/initializers/filepicker.rb"
    # run "ln -nfs #{shared_path}/config/initializers/omniauth.rb #{release_path}/config/initializers/omniauth.rb"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  task :please_work_gems, roles: :app do
    run "cd #{release_path} && bundle package"
    run "cd #{release_path} && rbenv rehash"
  end
  after "deploy:finalize_update", "deploy:please_work_gems"
  
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  end
  after 'deploy:update_code', 'deploy:symlink_uploads'

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"

  # after "deploy", "deploy:migrate"
end