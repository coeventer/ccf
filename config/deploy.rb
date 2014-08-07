require "bundler/capistrano"
set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
set :scm, :git

# ssh_options[:forward_agent] = true
# default_run_options[:pty] = true
default_run_options[:shell] = '/bin/bash --login'