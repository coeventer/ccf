class ContactMailer < ActionMailer::Base
  default :from => "no-reply@#{APP_CONFIG['mail']['domain']}"
  def contact_admins(message, organization=nil)
    @message = message
    admins = organization.nil? ? User.where(admin: true) : organization.users.where(admin: true)
    admins.each do |u|
      mail = mail(:to => u.email, :subject => "Contact form has been submitted") do |format|
        format.html
      end
      mail.deliver
    end
  end
end
