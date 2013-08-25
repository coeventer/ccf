class Project < ActiveRecord::Base
  attr_accessible :description, :title, :classification, :project_owner, :event
  
  has_many :comments, :class_name => "ProjectComment"
  has_many :ratings, :class_name => "ProjectRating"
  has_many :volunteers, :class_name => "ProjectVolunteer"
  has_many :tags, :class_name => "ProjectTag"
  has_one :project_owner, :class_name => "User"
  
  belongs_to :event
  
  validates :title, presence: true
  validates :description, presence: true
  validates :classification, presence: true
  
  # Checks to see if event can be voted on
  def voting_allowed?
    # As of today, cannot vote if project is in 'parking lot'
    if self.event.nil? then
      return false
    else
      return self.event.voting_enabled?
    end
  end
  
  # Checks to see if event can be volunteered for
  def volunteering_allowed?
    # As of today, cannot volunteer if project is in 'parking lot'
    if self.event.nil? then
      return false
    else
      return self.event.volunteering_enabled?
    end    
  end
end
