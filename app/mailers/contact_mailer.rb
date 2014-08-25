class ContactMailer < ActionMailer::Base
  def contact_admins(message)
    @message = message
    User.where(admin: true).each do |u|
      mail(:to => u.email, :subject => "Contact form has been submitted")
    end
  end

  def contact_organization_admins(message, organization)
    @message = message
    organization.users.where(admin: true).each do |u|
      mail(:to => u.email, :subject => "Contact form has been submitted")
    end
  end
end