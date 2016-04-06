class EventRegistration < ActiveRecord::Base
  attr_accessible :event_id, :user, :note, :participation_level
  delegate :organization_id, to: :event

  belongs_to :event
  belongs_to :user

  validates :user_id, :uniqueness => {:scope => :event_id}
  validates :participation_level, :presence => true

  after_create :send_notification

  PARTICIPATION_OPTIONS = ["Work on a project", "Help facilitate event", "Just visiting"]

  default_scope { order(:created_at)}

  def self.to_csv
    CSV.generate do |csv|
      csv << ["Name", "Email", "Registered On"]
      all.each do |registration|
        csv << [registration.user.name, registration.user.email, registration.created_at]
      end
    end
  end

  def send_notification
    RegistrationMailer.registration_created(self).deliver_now
  end
end
