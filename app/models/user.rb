class User < ActiveRecord::Base
  attr_accessible :admin, :department, :deptid, :email, :name, :x500id
  
  has_many :projects
  has_many :project_comments
  has_many :project_ratings
  has_many :project_volunteers
end
