raise "You must supply mail credentials. See the config/config.yml.example file." if !APP_CONFIG['mail']
ActionMailer::Base.smtp_settings  = {
  :authentication => :plain,
  :address => "smtp.mailgun.org",
  :port => 587,
  :domain => APP_CONFIG['mail']['domain'],
  :user_name => APP_CONFIG['mail']['user_name'],
  :password => APP_CONFIG['mail']['password']
}
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_url_options = {:host => APP_CONFIG['domain']}