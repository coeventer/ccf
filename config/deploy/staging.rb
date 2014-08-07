set :repository,  "git@github.com:chadfennell/ccf.git"
set :application, "ccf"

set :deploy_to, "/opt/ccf"

role :web, "104.131.197.72"
role :app, "104.131.197.72"

set :use_sudo, false
set :branch, "master"
set :deploy_via, :remote_cache
set :user, "deploy"
set :group, "deploy"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  # task :start do ; end
  # task :stop do ; end
  # task :restart, :roles => :app, :except => { :no_release => true } do
  #   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  # end

  desc "Copy yml files to the project directory"
  task :copy_yml_files, :roles => :app do
    run "cp -pf #{shared_path}/db/database.yml #{release_path}/config"
    run "cp -pf #{shared_path}/config/providers.yml #{release_path}/config"
    run "cp -pf #{shared_path}/config/email.yml #{release_path}/config"
  end

  before 'deploy:assets:precompile', 'deploy:copy_yml_files'
end