class EventModerator < ActiveRecord::Base
  attr_accessible :event_id, :user_id
  validates :user_id, :uniqueness => {:scope => :event_id}
end
