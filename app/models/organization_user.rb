class OrganizationUser < ActiveRecord::Base
  attr_accessible :admin, :organization_id, :verified, :user, :user_department, :user_id
  belongs_to :organization
  belongs_to :user, autosave: true

  validates :user_id, uniqueness: {scope: :organization_id}

  after_create :welcome_email
  after_update :verified_email, :if => "verified_changed? && verified?"

  delegate :admin, :name, :email, :uid, :department, :department=, to: :user, prefix: true

  default_scope {includes(:user)}

  def welcome_email
    UserMailer.organization_user_created(user, organization)
  end

  def verified_email
    UserMailer.user_verified(user, organization)
  end

  def email
    user_email
  end
end
