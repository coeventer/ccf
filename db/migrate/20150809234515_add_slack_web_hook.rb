class AddSlackWebHook < ActiveRecord::Migration
  def change
    add_column :organizations, :slack_webhook_url, :string, default: nil
  end
end
