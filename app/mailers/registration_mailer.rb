class RegistrationMailer < ActionMailer::Base
  default :from => "no-reply@#{APP_CONFIG['mail']['domain']}"
  def registration_created(registration)
    @registration = registration
    @user = registration.user
    @event = registration.event
    mail = mail(:to => @user.email, :subject => "Registered For \"#{@event.title}\"") do |format|
      format.text
      format.html
    end
    mail
  end
end
