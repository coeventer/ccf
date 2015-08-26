class MassEventInvitation
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  attr_accessor :event, :user_ids, :emails, :organization

  def initialize(event, organization, params, options={})
    self.user_ids = params[:user_ids]
    self.emails = params[:emails]
    self.event = event
    self.organization = organization
  end

  def invite
    invite_users
    invite_emails
  end

  def invite_users
    return if user_ids.blank?

    user_ids.each do |id|
      user = User.where(id: id).first
      Invitation.create(user_id: user.id, context_type: 'Event', context_id: event.id, organization_id: organization.id) if user
    end
  end

  def invite_emails
    return if emails.blank?

    emails.split(",").each do |email|
      next unless email =~ VALID_EMAIL_REGEX
      Invitation.create(email: email, context_type: 'Event', context_id: event.id, organization_id: organization.id)
    end
  end

  def persisted?
    false
  end

end
