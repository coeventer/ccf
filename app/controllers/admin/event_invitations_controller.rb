class Admin::EventInvitationsController < Admin::AdminController
  def index
    @event = Event.find(params[:event_id])
    @invitations = Invitation.context(@event).decorate
    @users = current_organization.users.map(&:user)

    @inviter = MassInvitation.new(@event, current_organization, {})
  end

  def create
    event = Event.find(params[:event_id])
    inviter = MassInvitation.new(event, current_organization, params[:mass_invitation])
    inviter.invite

    redirect_to admin_event_invitations_path(event)
  end
end
