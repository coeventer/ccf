class ContactMailer < ActionMailer::Base
  default :from => "no-reply@#{APP_CONFIG["domain"]}"
  def contact_admins(message, organization=nil)
    @message = message
    admins = organization.nil? ? User.where(admin: true) : organization.users.where(admin: true)
    admins.each do |u|
      mail(:to => u.email, :subject => "Contact form has been submitted")
    end
  end
end
