require './config/boot'
require 'airbrake/capistrano'
require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require 'rvm/capistrano'

set :rvm_ruby_string, '2.0.0-p247'
set :rvm_type, :system

set :stages, %w(demo production)
#set :default_stage, "demo"

ssh_options[:forward_agent] = true
set :application, 'sutco'
set :scm, :git
set :deploy_via, :remote_cache
set :repository, 'git@epi-stu-repos1-git.shef.ac.uk:genesys-team10/sutco.git'
set :use_sudo, false
set :keep_releases, 2

namespace :deploy do
  
  # #  Uncomment the following bit to skip assets precompile if nothing changed.
  # #  N.B. You mustn't enable this task on your first deploy, or it will fail.
  
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile"
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end


  # desc "Set up shared folders"
  # task :setup_shared do
  #   # Create the upload directory folder
  #   run "mkdir -p #{File.join(shared_path, 'uploads')}"
  #   # 2775 - rwxrwsr-x (setgid for group access to folder)
  #   run "chmod 2775 #{File.join(shared_path, 'uploads')}"
  # end

  desc "Symlink folders on each release."
  task :symlink_shared do
    # Symlink the database configuration
    run "ln -nfs #{File.join(shared_path, 'config', 'database.yml')} #{File.join(release_path,'config','database.yml')}"
    # Symlink the upload directory
    # run "ln -nfs #{File.join(shared_path, 'uploads')} #{File.join(release_path, 'uploads')}"
    # No need to symlink if we're not doing caching
    #run "ln -nfs #{shared_path}/cache #{release_path}/public/cache"
  end
  
  namespace :db do 
    desc "Seed the database."
    task :seed do
      run "cd #{current_release}; bundle exec rake RAILS_ENV=#{rails_env} db:seed"
    end
  end
end

# Handle restarting Passenger on demo and production sites
namespace :passenger do
  desc "Start the Passenger server (not supported)"
  task :start, :roles => :app do; passenger.restart; end

  desc "Restart the Passenger server"
  task :restart, :roles => :app do  
    run "touch #{File.join(current_release, 'tmp', 'restart.txt')}"
  end

  desc "Stop the Passenger server (not supported)"
  task :stop, :roles => :app do; end
end

# Symlink the database and shared file
after 'deploy:finalize_update', 'deploy:symlink_shared'

# Clean up old deployments
after 'deploy:restart', 'deploy:cleanup'
