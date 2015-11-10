class User < ActiveRecord::Base
  attr_accessible :admin, :department, :deptid, :email, :name, :uid, :image, :verified, :send_notifications

  has_many :projects, :foreign_key => :project_owner_id
  has_many :project_comments
  has_many :project_ratings
  has_many :project_volunteers
  has_many :event_registrations
  has_many :organization_users
  has_many :invitations
  has_many :provider_users, dependent: :destroy

  default_scope { order(:created_at)}

  after_create :create_provider_user


  # See: https://github.com/zquestz/omniauth-google-oauth2 
  def self.create_with_omniauth(auth, organization=nil)
    user = create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.image = auth["info"]["image"]
      user.verified = false

      # First user to sign up becomes an admin... so... sign up fast.
      user.admin = 1 if User.count < 1
    end

    organization.users.create(user: user) if organization
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
      return true
    else
      return false
    end
  end

  # TODO: Temporary until we add another provider, remove and refactor when done
  def create_provider_user
    ProviderUser.create(
      user_id: id,
      provider: ProviderUser::GOOGLE_PROVIDER,
      uid: uid,
      validated: true
    )
  end

  def pending_invitations
    Invitation.pending.user(self)
  end
end
