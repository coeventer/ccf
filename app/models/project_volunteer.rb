class ProjectVolunteer < ActiveRecord::Base
  attr_accessible :interest_level, :project_id, :user_id
end
