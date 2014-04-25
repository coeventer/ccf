ActionMailer::Base.smtp_settings = {
  :address              => "smtp.umn.edu",
  :port                 => 587,
  :user_name            => "<user name here>",
  :domain               => "<domain here>",
  :password             => "<your password here>",
  :authentication       => :login,
  :enable_starttls_auto => true
}