class AddEmailConfirmationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_confirmed, :boolean, :default => false
    add_column :users, :email_confirmation_token, :string
  end
end
