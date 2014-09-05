class EventComment < ActiveRecord::Base
  attr_accessible :description

  belongs_to :user
  belongs_to :event

  default_scope { order("created_at desc")}
end
