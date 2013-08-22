class ProjectRating < ActiveRecord::Base
  attr_accessible :project_id, :rating, :user_id
end
