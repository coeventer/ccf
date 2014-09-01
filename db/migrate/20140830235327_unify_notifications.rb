class UnifyNotifications < ActiveRecord::Migration
  def change
    add_column    :users, :send_notifications, :boolean, default: true
    remove_column :users, :alert_when_owner
    remove_column :users, :alert_when_commenter
  end
end
