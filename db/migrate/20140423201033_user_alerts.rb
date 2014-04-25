class UserAlerts < ActiveRecord::Migration
  def change
    add_column :users, :alert_when_owner, :boolean
    add_column :users, :alert_when_commenter, :boolean
  end
end
