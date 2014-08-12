# Load the rails application
require File.expand_path('../application', __FILE__)

APP_CONFIG = YAML::load(File.open(Rails.root.join "config", "config.yml"))[Rails.env]

# Initialize the rails application
CampusCodefest::Application.initialize!
