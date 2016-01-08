class Event < ActiveRecord::Base
  include SlackNotifiable

  attr_accessible :end_date, :start_date, :title, :voting_end_date, :voting_enabled, :volunteer_end_date,
    :volunteering_enabled, :description, :registration_end_dt, :registration_maximum,
    :live, :schedule, :other_info, :event_logo, :dashboard_enabled, :remove_event_logo

  belongs_to :organization
  has_many :projects
  has_many :registrations, :class_name => "EventRegistration"
  has_many :event_registrations, dependent: :delete_all
  has_many :moderators, :class_name => "EventModerator"
  has_many :ratings, :through => :projects
  has_many :volunteers, :through => :projects
  has_many :comments, :through => :projects
  has_many :event_comments

  mount_uploader :event_logo, EventLogoUploader

  validates :title, :presence => true
  validates :description, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true

  with_options if: :live do |live|
    live.validates :schedule, :presence => true
    live.validates :voting_enabled, :inclusion => [true, false]
    live.validates :voting_end_date,  :presence => true, if: "voting_enabled && live"
    live.validates :volunteering_enabled, :inclusion => [true, false]
    live.validates :volunteer_end_date,  :presence => true, if: "volunteering_enabled && live"
    live.validates :registration_end_dt, :presence => true
    live.validates :registration_maximum, :presence => true
  end

  default_scope { where(organization_id: Organization.current_id).order("events.start_date desc") }
  scope :future, -> { where("end_date > ?", Date.today) }

  before_destroy :unassign_projects
  before_destroy :delete_volunteers

  alias_attribute :name, :title

  [:start_date, :end_date, :voting_end_date, :volunteer_end_date, :registration_end_dt].each do |v|
    date_handler_name = "input_#{v}"

    attr_accessible date_handler_name
    define_method(date_handler_name) { self[v].try(:in_time_zone) }
    define_method("#{date_handler_name}=") {|value| self[v] = Time.zone.parse(value) }
  end

  # Voting is enabled if the voting enabled boolean is turned on, it is before the event start date
  # and before the voting end date, if it is set
  def voting_enabled?
    return self.live? && self.voting_enabled && (self.voting_end_date.nil? ? true : Time.now < self.voting_end_date) && Time.now < self.start_date
  end

  # Volunteering is enabled if the volunteering enabled boolean is turned on, it is before the event ends
  # and before the volunteering end date, if it is set
  def volunteering_enabled?
    return self.live? && self.volunteering_enabled && (self.volunteer_end_date.nil? ? true : Time.now < self.volunteer_end_date) && Time.now <= self.end_date
  end

  def registration_enabled?
    return self.live? && (self.registrations_remaining > 0) && (self.registration_end_dt.nil? ? true : Time.now < self.registration_end_dt) && Time.now < self.end_date
  end

  def registered?(user)
    return !self.registrations.find_by_user_id(user.id).nil?
  end

  def registrations_remaining
    return self.registration_maximum - self.registrations.count
  end

  def volunteer_count
    self.volunteers.count
  end

  def vote_count
    self.ratings.count
  end

  def completed?
    Time.now > end_date
  end

  def moderator?(user)
    return !self.moderators.find_by_user_id(user.id).nil?
  end

  def pretty_dates
    return "from #{self.start_date.strftime('%B %e at %l:%M%P')} to #{self.end_date.strftime('%B %e at %l:%M%P')}"
  end

  def unassign_projects
    self.projects.update_all(event_id: nil)
  end

  def delete_volunteers
    self.volunteers.each(&:destroy)
  end

  def publishable?
    self.live = true
    publishable = valid?
    self.live = false if self.live_changed?
    publishable
  end

  def to_param
    [id, title.parameterize].join("-")
  end

  def self.live
    return self.where(live: true)
  end

  def slack_message
    "A new event has been created: #{title}. #{description}"
  end
end
