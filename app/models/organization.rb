class Organization < ActiveRecord::Base
  attr_accessible :auto_verify, :auto_verify_domains, :description, :name, :subdomain, :website
  cattr_accessor :current_id

  has_many :events
  has_many :projects
  has_many :users, :class_name => "OrganizationUser"

  validates :name, :subdomain, presence: true
  validates :subdomain, uniqueness: true

  def admin?(user)
    return true is user.admin?
    organization_user = users.where(user_id: user).first
    return false if organization_user.nil?
    return organization_user.admin?
  end

  def verified?(user)
    organization_user = users.where(user_id: user).first
    return false if organization_user.nil?
    return organization_user.verified?
  end
end
