class Invitation < ActiveRecord::Base
  include Tokenable

  attr_accessible :context_id, :context_type, :email, :organization_id, :status, :token, :user_id

  after_create :send_notification

  scope :pending, ->{ where(status: 'pending') }
  scope :user, ->(user){ where("invitations.email = ? or invitations.user_id = ?", user.email, user.id) }

  delegate :name, to: :invited_resource

  def context_types
    %w{Event Organization}
  end

  def statuses
    %w{pending accepted declined}
  end

  def event?
    context_type.eql?('Event')
  end

  def organization?
    context_type.eql?('Organization')
  end

  def invited_resource
    @invited_resource ||= event? ? Event.find(context_id) : Organization.find(context_id)
  end

  def decline(user)
    update_attributes(status: 'declined')
  end

  def accept(user)
    event? ? accept_event(user) : accept_organization(user)
  end

  def accept_organization(user)
    org_user = invited_resource.users.create(user: user, verified: true)

    self.update_attributes(status: 'accepted') if org_user
    org_user
  end
  private :accept_organization

  def accept_event(user)
    reg = invited_resource.event_registrations.create(user: user)

    self.update_attributes(status: 'accepted') if reg
    reg
  end
  private :accept_event

  def send_notification
    # TODO
    # InvitationMailer.invitation_created(self)
  end
  private :send_notification

end
