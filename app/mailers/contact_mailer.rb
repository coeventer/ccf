class ContactMailer < ActionMailer::Base
  default :from => "no-reply@#{APP_CONFIG['mail']['domain']}"
  def contact_admins(message, user, organization=nil)
    @message = message

    mail = mail(:to => user.email, :subject => "Contact form has been submitted") do |format|
      format.html
    end
  end
end
