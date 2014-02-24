require "bundler/capistrano"

set :application, "campus_codefest"
set :repository,  "git@github.umn.edu:ccf/campus_codefest.git"
set :scm, :git
set :user, "deploy"
set :deploy_to, "/swadm/www/campus_codefest"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "oir-web1.oit.umn.edu"                          # Your HTTP server, Apache/etc
role :app, "oir-web1.oit.umn.edu"                         # This may be the same as your `Web` server

set :ssh_options, { :forward_agent => true }
set :use_sudo, false
set :branch, "master"
set :deploy_via, :remote_cache

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Copy database.yml file to the project directory"
  task :copy_database_yml, :roles => :app do
    run "cp -pf #{shared_path}/db/database.yml #{release_path}/config"
  end  

  before 'deploy:assets:precompile', 'deploy:copy_database_yml'
end