class EventModerator < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  attr_accessible :event_id, :user_id
  validates :user_id, :uniqueness => {:scope => :event_id}

  after_create :send_mail

  def send_mail
    UserMailer.event_moderator(user, event).deliver_now
  end
end
