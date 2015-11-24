class ProviderUser < ActiveRecord::Base
  include Tokenable
  belongs_to :user

  attr_accessible :provider, :token, :user_id, :uid, :validated

  # TODO: Provider should be a parameter as more providers are added
  def self.find_and_update_uid(auth)
    provider_user = ProviderUser.where(uid: auth.uid, provider: auth.provider).first
    return nil unless provider_user

    user = provider_user.user
    user.image = auth.info.image
    user.save if user.changed?

    return user
  end
end
