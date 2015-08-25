class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :token
      t.integer :organization_id
      t.string :context_type
      t.integer :context_id
      t.integer :user_id
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
