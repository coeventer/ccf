class Project < ActiveRecord::Base
  attr_accessible :description, :title, :classification, :project_owner, :event_id,
  :approved, :repository, :project_comments_count, :project_ratings_count, :project_volunteers_count

  has_many :comments, :class_name => "ProjectComment"
  has_many :ratings, :class_name => "ProjectRating"
  has_many :volunteers, :class_name => "ProjectVolunteer"
  has_many :tags, :class_name => "ProjectTag"

  belongs_to :project_owner, :class_name => "User"
  belongs_to :organiztion
  belongs_to :event

  validates :title, presence: true
  validates :description, presence: true
  #validates :classification, presence: true

  CLASSIFICATIONS = ["Develop an App", "Learn and Explore", "Specify and Design", "Other"]

  #scopes for sorting projects
  default_scope { where(organization_id: Organization.current_id) }
  scope :backlog, where("event_id is null")
  scope :most_commented, order('project_comments_count DESC')
  scope :most_liked, order('project_ratings_count DESC')
  scope :most_help, order('project_volunteers_count DESC')

  # Checks to see if event can be voted on
  def voting_allowed?
    # As of today, cannot vote if project is in 'parking lot'
    if self.event.nil? then
      return true
    else
      return self.event.voting_enabled?
    end
  end

  # Check to see if user has voted on project
  def voted_on?(user)
    return !self.ratings.find_by_user_id(user.id).nil?
  end

  # Vote (rate) a project for a given user
  def toggle_vote(user)
    if self.voting_allowed? then
      if !self.voted_on?(user)
        self.ratings.create(:user_id => user.id)
      else
        v = self.ratings.find_by_user_id(user.id)
        v.destroy
      end
    end
  end

  # Add a project volunteer
  def volunteer(user)
    if self.volunteering_allowed? && !self.volunteered_for?(user) then
      self.volunteers.create(:user_id => user.id)
    end
  end

  # remove a project volunteer
  def unvolunteer(user)
    if self.volunteering_allowed? && self.volunteered_for?(user) then
      v = self.volunteers.find_by_user_id(user.id)
      v.destroy unless v.nil?
    end
  end

  # Check to see if user has volunteered for project
  def volunteered_for?(user)
    return !self.volunteers.find_by_user_id(user.id).nil?
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

  def other?
    return self.classification.eql?("Other")
  end

  def vote_count
    self.ratings.count
  end

  def comment_count
    self.comments.count
  end

  def volunteer_count
    self.volunteers.count
  end

  def to_param
    [id, title.parameterize].join("-")
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ["Title", "Classification", "Votes", "Volunteers", "Comments", "Created On"]
      all.each do |project|
        csv << [project.title, project.classification, project.vote_count, project.volunteer_count, project.comment_count, project.created_at]
      end
    end
  end
end
