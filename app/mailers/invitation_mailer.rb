class InvitationMailer < ActionMailer::Base
  default :from => "no-reply@#{APP_CONFIG['mail']['domain']}"
  def invitation_created(invitation)
    @invitation = invitation.decorate
    mail = mail(:to => @invitation.email, :subject => @invitation.title) do |format|
      format.text
      format.html
    end

    mail.deliver
  end
end
