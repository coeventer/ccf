class Event < ActiveRecord::Base
  attr_accessible :end_date, :start_date, :title, :voting_end_date, :voting_enabled, :volunteer_end_date, 
    :volunteering_enabled, :description, :registration_end_dt, :registration_maximum,
    :live, :schedule, :other_info
  
  has_many :projects
  has_many :registrations, :class_name => "EventRegistration"
  has_many :event_registrations
  has_many :moderators, :class_name => "EventModerator"
  has_many :ratings, :through => :projects
  has_many :volunteers, :through => :projects
  has_many :comments, :through => :projects  
  
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :title, :presence => true
  validates :schedule, :presence => true
  validates :description, :presence => true
  validates :voting_enabled, :inclusion => [true, false]
  validates :volunteering_enabled, :inclusion => [true, false]
  validates :registration_end_dt, :presence => true
  validates :registration_maximum, :presence => true
  
  # Voting is enabled if the voting enabled boolean is turned on, it is before the event start date
  # and before the voting end date, if it is set
  def voting_enabled?
    return self.live? && self.voting_enabled && (self.voting_end_date.nil? ? true : Date.today < self.voting_end_date.to_date) && Date.today < self.start_date.to_date
  end
  
  # Volunteering is enabled if the volunteering enabled boolean is turned on, it is before the event ends
  # and before the volunteering end date, if it is set  
  def volunteering_enabled?
    return self.live? && self.volunteering_enabled && (self.volunteer_end_date.nil? ? true : Date.today < self.volunteer_end_date.to_date) && Date.today <= self.end_date.to_date
  end

  def registration_enabled?
    return self.live? && (self.registrations_remaining > 0) && (self.registration_end_dt.nil? ? true : Date.today < self.registration_end_dt.to_date) && Date.today < self.end_date.to_date
  end

  def registered?(user)
    return !self.registrations.find_by_user_id(user.id).nil?
  end

  def registrations_remaining
    return self.registration_maximum - self.registrations.count
  end

  def volunteer_count
    self.volunteers.count
  end

  def vote_count
    self.ratings.count
  end

  def completed?
    Date.today > self.end_date.to_date
  end

  def pretty_dates
    return "from #{self.start_date.strftime('%B%e at %l:%M%P')} to #{self.end_date.strftime('%B%e at %l:%M%P')}"
  end

  def to_param
    [id, title.parameterize].join("-")
  end  

  def self.live
    return self.where(live: true)
  end
end
