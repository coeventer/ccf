class Organization < ActiveRecord::Base
  attr_accessible :auto_verify, :auto_verify_domains, :description, :name, :subdomain, :website
  cattr_accessor :current_id

  has_many :events
  has_many :projects
  has_many :users, :class_name => "OrganizationUser"

  validates :name, :subdomain, presence: true
  validates :subdomain, uniqueness: true

  def admin?(user)
    user = users.where(user_id: user).first
    return false if user.nil?
    return user.admin? || user.user.admin?
  end

  def verified?(user)
    user = users.where(user_id: user).first
    return false if user.nil?
    return user.verified?
  end
end
