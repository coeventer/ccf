class ProjectRating < ActiveRecord::Base
  attr_accessible :project_id, :rating, :user_id
  
  belongs_to :project
  belongs_to :user
end
