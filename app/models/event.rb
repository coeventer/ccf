class Event < ActiveRecord::Base
  attr_accessible :end_date, :start_date, :title, :voting_end_date, :voting_enabled, :volunteer_end_date, :volunteering_enabled
  
  has_many :projects
  has_many :moderators, :class_name => "EventModerators"
  has_many :registrations, :class_name => "EventRegistrations"
  
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true
  validates :voting_enabled, :presence => true
  #validates :voting_end_date, :format => {:date => true}
  #validates :volunteer_end_date, :format => {:date => true}
  
  def voting_enabled?
    return voting_enabled && Date.today < voting_end_date
  end
  
  def volunteering_enabled?
    return volunteering_enabled && Date.today < volunteer_end_date
  end
end
