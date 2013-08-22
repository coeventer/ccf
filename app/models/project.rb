class Project < ActiveRecord::Base
  attr_accessible :description, :title
  
  has_many :project_comments
  has_many :project_ratings
  has_many :project_volunteers
  has_one :project_owner, :class_name => "User"
  
  belongs_to :event
end
