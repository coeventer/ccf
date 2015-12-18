class OrganizationUser < ActiveRecord::Base
  attr_accessible :admin, :organization_id, :verified, :user, :user_department, :user_id

  WILDCARD_DOMAIN = '*'

  belongs_to :organization
  belongs_to :user, autosave: true

  validates :user_id, uniqueness: {scope: :organization_id}

  before_create :auto_verify
  after_create :welcome_email
  after_update :verified_email, :if => "verified_changed? && verified?"

  delegate :admin, :name, :email, :uid, :department, :department=, to: :user, prefix: true

  default_scope {includes(:user)}
  scope :unverified, ->{ where(verified: false) }

  def welcome_email
    UserMailer.organization_user_created(user, organization).deliver_now
  end

  def verified_email
    UserMailer.user_verified(user, organization).deliver_now
  end

  def email
    user_email
  end

  def auto_verify?
    return false unless organization.auto_verify?

    organization.auto_verify_domains == WILDCARD_DOMAIN || organization.auto_verify_domains.split(',').include?(user_email.split("@").last)
  end

  def auto_verify
    return true if self.verified

    self.verified = self.auto_verify?
    true
  end
end
