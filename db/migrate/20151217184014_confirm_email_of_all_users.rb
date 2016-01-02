class ConfirmEmailOfAllUsers < ActiveRecord::Migration
  # Making sure this migration always works, even if the User model disappears
  class User < ActiveRecord::Base
  end

  def change
    User.all.each do |user|
      user.email_confirmed = true
      user.save!
    end
  end
end
