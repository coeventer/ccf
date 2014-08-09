class User < ActiveRecord::Base
  attr_accessible :admin, :department, :deptid, :email, :name, :uid, :image, :verified, :alert_when_owner, :alert_when_commenter

  has_many :projects, :foreign_key => :project_owner_id
  has_many :project_comments
  has_many :project_ratings
  has_many :project_volunteers
  has_many :event_registrations
  has_many :organization_users

  AUTO_VERIFY_DOMAINS = ['umn.edu']

  default_scope { order(:created_at)}


  # See: https://github.com/zquestz/omniauth-google-oauth2 
  def self.create_with_omniauth(auth, organization=nil)
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
      if organization
        org_user = organization.users.create(user: user)
        org_user.verified = false

        if organization.auto_verify? then
          org_user.verified = true if organization.auto_verify_domains.include? user.email.split("@").last
        end
        
      end
    end
  end

  def label
    if !self.department.nil? and !self.department.empty? then
      self.name + ' - ' + self.department
    else
      self.name
    end
  end
end
