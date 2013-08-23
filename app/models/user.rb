class User < ActiveRecord::Base
  attr_accessible :admin, :department, :deptid, :email, :name, :x500id
  
  has_many :projects
  has_many :project_comments
  has_many :project_ratings
  has_many :project_volunteers
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.x500id = auth["uid"]
      user.name = auth["info"]["name"]
      user.admin = 1 if User.count < 1
    end    
  end  
end
