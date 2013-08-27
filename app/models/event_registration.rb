class EventRegistration < ActiveRecord::Base
  attr_accessible :event_id, :user, :not
  
  belongs_to :event
  belongs_to :user
  
  validates :user_id, :uniqueness => {:scope => :event_id}
end
