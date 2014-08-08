class OrganizationUser < ActiveRecord::Base
  attr_accessible :admin, :organization_id, :verified, :user
  belongs_to :organization
  belongs_to :user
end
