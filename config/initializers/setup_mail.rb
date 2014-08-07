config = config = APP_CONFIG.fetch("email", [])
if !config.empty?
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.umn.edu",
    :port                 => 587,
    :user_name            => config["user"],
    :domain               => config["domain"],
    :password             => config["password"],
    :authentication       => :login,
    :enable_starttls_auto => true
  }
else
  raise "You must provide an config/email.yml file to run this application. See config/email.yml.example for an example."
end

