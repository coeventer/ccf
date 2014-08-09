class OrganizationUser < ActiveRecord::Base
  attr_accessible :admin, :organization_id, :verified, :user, :user_department
  belongs_to :organization
  belongs_to :user, autosave: true

  delegate :admin, :name, :email, :uid, :department, :department=, to: :user, prefix: true

  default_scope {includes(:user)}

end
