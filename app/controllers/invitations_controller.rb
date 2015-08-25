class InvitationsController < OrganizationController
  skip_before_filter :publically_accessible
  before_filter :find_invitation, only: [:accept, :decline, :show]

  def index
    @invitations = current_user.pending_invitations.decorate
  end

  def show
    @invitation = find_invitation.decorate
  end

  def accept
    @invitation.accept(current_user)

    if @invitation.event?
      redirect_to event_path(@invitation.invited_resource)
    else
      redirect_to root_path(subdomain: current_organization.subdomain)
    end
  end

  def decline
    @invitation.decline(current_user)

    redirect_to invitations_path
  end

  def find_invitation
    @invitation = params[:token] ? find_token_invitation : find_user_invitation
  end

  def find_user_invitation
    current_user.invitations.find(params[:id])
  end

  def find_token_invitation
    Invitation.where(id: params[:id], token: params[:token]).first!
  end
end
