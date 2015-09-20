class Invitation < ActiveRecord::Base
  include Tokenable

  attr_accessible :context_id, :context_type, :email, :organization_id, :status, :token, :user_id

  belongs_to :user
  belongs_to :organization

  after_create :send_notification

  scope :pending, ->{ where(status: 'pending') }
  scope :user, ->(user){ where("invitations.email = ? or invitations.user_id = ?", user.email, user.id) }
  scope :context, ->(context){ where(context_type: context.class.name, context_id: context.id) }

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

  def pending?
    status == 'pending'
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
    invited_resource.organization.users.create(user: user, verified: true)
    reg = invited_resource.event_registrations.create(user: user, participation_level: "Invited")

    self.update_attributes(status: 'accepted') if reg
    reg
  end
  private :accept_event

  def send_notification
    InvitationMailer.invitation_created(self)
  end
  private :send_notification

end
