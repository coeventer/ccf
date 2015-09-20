class Admin::InvitationsController < Admin::AdminController
  def index
    @invitations = Invitation.context(current_organization).decorate
    @users = current_organization.users.map(&:user)

    @inviter = MassInvitation.new(current_organization, current_organization, {})
  end

  def create
    inviter = MassInvitation.new(current_organization, current_organization, params[:mass_invitation])
    inviter.invite

    redirect_to admin_organization_invitations_path
  end

end
