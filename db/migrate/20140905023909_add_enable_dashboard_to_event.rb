class AddEnableDashboardToEvent < ActiveRecord::Migration
  def change
    add_column :events, :dashboard_enabled, :boolean, default: true
  end
end
