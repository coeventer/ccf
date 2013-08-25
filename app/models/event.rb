class Event < ActiveRecord::Base
  attr_accessible :end_date, :start_date, :title, :voting_end_date, :voting_enabled, :volunteer_end_date, :volunteering_enabled
  
  has_many :projects
  has_many :moderators, :class_name => "EventModerators"
  has_many :registrations, :class_name => "EventRegistrations"
  
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true
  validates :voting_enabled, :inclusion => [true, false]
  validates :volunteering_enabled, :inclusion => [true, false]
  #validates :voting_end_date, :format => {:date => true}
  #validates :volunteer_end_date, :format => {:date => true}
  
  # Voting is enabled if the voting enabled boolean is turned on, it is before the event start date
  # and before the voting end date, if it is set
  def voting_enabled?
    return self.voting_enabled && (self.voting_end_date.nil? ? true : Date.today < self.voting_end_date) && Date.today < self.start_date
  end
  
  # Volunteering is enabled if the volunteering enabled boolean is turned on, it is before the event ends
  # and before the volunteering end date, if it is set  
  def volunteering_enabled?
    return self.volunteering_enabled && (self.volunteer_end_date.nil? ? true : Date.today < self.volunteer_end_date) && Date.today <= self.end_date
  end
end
