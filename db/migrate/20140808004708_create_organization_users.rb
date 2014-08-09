class CreateOrganizationUsers < ActiveRecord::Migration
  def change
    create_table :organization_users do |t|
      t.integer :organization_id
      t.integer :user_id
      t.boolean :verified
      t.boolean :admin

      t.timestamps
    end
  end
end
