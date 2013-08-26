class EventRegistration < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :note
  validates :user_id, :uniqueness => {:scope => :event_id}
end
