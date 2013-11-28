server "epi-stu-gen-demo2-ruby20.shef.ac.uk", :app, :web, :db, :primary => true

set :deploy_to, "/srv/services/#{application}"
set :user, "#{application}"
set :rails_env, "demo"
set :branch, "deploy"
set :group_writable, false

namespace :deploy do
  task :start, :roles => :app do;   passenger.start;    end
  task :restart, :roles => :app do; passenger.restart;  end
  task :stop, :roles => :app do;    passenger.stop;     end
end
