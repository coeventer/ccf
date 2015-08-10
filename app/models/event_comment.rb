class EventComment < ActiveRecord::Base
  attr_accessible :description

  belongs_to :user
  belongs_to :event
  belongs_to :organization, through: :event

  default_scope { order("created_at desc")}

end
