class User < ActiveRecord::Base
  attr_accessible :department, :deptid, :email, :name, :uid, :image, :verified, :send_notifications

  has_many :projects, :foreign_key => :project_owner_id
  has_many :project_comments
  has_many :commented_projects, through: :project_comments, source: :project
  has_many :project_ratings
  has_many :project_volunteers
  has_many :event_registrations
  has_many :organization_users
  has_many :invitations
  has_many :provider_users, dependent: :destroy

  before_create :generate_email_confirmation_token

  default_scope { order(:created_at)}
  scope :email_confirmed, ->{where(email_confirmed: true)}
  scope :project_notifiable, ->(id){ joins("INNER JOIN project_comments AS pc ON pc.user_id = users.id INNER JOIN projects AS p ON p.id = pc.project_id").where("p.id = ?", id).where(send_notifications: true ) }


  # See: https://github.com/zquestz/omniauth-google-oauth2 
  def self.create_with_omniauth(auth, organization=nil)
    # How do we find the user based on provider and uid? 

    # 1. Attempt to find the ProviderUser IDed by the auth
    pu = ProviderUser.find_by(uid: auth.uid, provider: auth.provider)
    user = pu.user if pu

    # 2. If 1 didn't work, attempt to find the user by auth provided email address
    user = User.find_by(email: auth.info.email) if !user and auth.info.has_key?('email')

    # 3. If 1 and 2 didn't work, assume the user doesn't exist yet. 
    user ||= create! do |new_user|
      new_user.uid = auth.uid
      new_user.name = auth.info.name
      new_user.image = auth.info.image
      new_user.verified = false

      if auth.info.key?('email')
        new_user.email = auth.info.email
        # Assume the OAuth provider has confirmed the user's email address
        new_user.email_confirmed = true
      end

      # First user to sign up becomes an admin... so... sign up fast.
      new_user.admin = 1 if User.count < 1
    end

    user.provider_users.create(provider: auth.provider, uid: auth.uid, validated: true)
    organization.users.where(user: user).first_or_create if organization
    user
  end

  def label
    if !self.department.nil? and !self.department.empty? then
      self.name + ' - ' + self.department
    else
      self.name
    end
  end

  def deactivate
    if self.update_attributes(uid: nil, name: "Deactivated Account", email: "None", image: nil, admin: false, verified: false)
      organization_users.update_all(admin: false, verified: false)
      provider_users.each(&:destroy)
      true
    else
      false
    end
  end

  def pending_invitations
    Invitation.pending.user(self)
  end

  def confirm_email(token)
    self.email_confirmed = (token == self.email_confirmation_token)
    self.save! if self.changed?
    organization_users.each(&:auto_verify!)
  end

  def set_unconfirmed_email(new_email)
    unless self.email == new_email
      self.unconfirm_email
      self.email = new_email
      self.save!
      UserMailer.confirm_email(self).deliver
      return true
    end
    return false
  end

  def unconfirm_email
    self.email_confirmed = false
    generate_email_confirmation_token
    self.save!
  end

  private
  def generate_email_confirmation_token
    self.email_confirmation_token = SecureRandom.urlsafe_base64.to_s if self.email_confirmation_token.blank?
  end
end
