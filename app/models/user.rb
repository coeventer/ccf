class User < ActiveRecord::Base
  attr_accessible :admin, :department, :deptid, :email, :name, :uid, :image, :verified, :alert_when_owner, :alert_when_commenter

  has_many :projects, :foreign_key => :project_owner_id
  has_many :project_comments
  has_many :project_ratings
  has_many :project_volunteers
  has_many :event_registrations

  AUTO_VERIFY_DOMAINS = ['umn.edu']

  default_scope { order(:created_at)}


  # See: https://github.com/zquestz/omniauth-google-oauth2 
  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.image = auth["info"]["image"]
      user.alert_when_owner = true
      # Disabling by default commenter emails for now. We can easily enable it 
      # if we get requests for this feature
      user.alert_when_commenter = false
      user.verified = false

      # First user to sign up becomes an admin... so... sign up fast.
      user.admin = 1 if User.count < 1

      # If user belongs to a auto-verify domain... verify
      user.verified = true if AUTO_VERIFY_DOMAINS.include? user.email.split("@").last
    end
  end
end
