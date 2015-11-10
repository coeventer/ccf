class CreateProviderUsers < ActiveRecord::Migration
  def change
    create_table :provider_users do |t|
      t.string :uid
      t.string :provider
      t.integer :user_id
      t.string :token
      t.boolean :validated, default: false

      t.timestamps
    end

    User.all.each(&:create_provider_user)
  end
end
