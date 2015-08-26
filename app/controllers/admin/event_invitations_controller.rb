class Admin::EventInvitationsController < Admin::AdminController
  def index
    @event = Event.find(params[:event_id])
    @invitations = Invitation.where(context_type: "Event", context_id: @event.id).decorate
    @users = current_organization.users.map(&:user)

    @inviter = MassEventInvitation.new(@event, current_organization, {})
  end

  def create
    event = Event.find(params[:event_id])
    inviter = MassEventInvitation.new(event, current_organization, params[:mass_event_invitation])
    inviter.invite

    redirect_to admin_event_invitations_path(event)
  end
end
