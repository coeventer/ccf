class Event < ActiveRecord::Base
  attr_accessible :end_date, :start_date, :title, :voting_end_date
  
  has_many :projects
end
