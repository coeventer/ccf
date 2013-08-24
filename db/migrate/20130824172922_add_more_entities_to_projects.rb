class AddMoreEntitiesToProjects < ActiveRecord::Migration
  def change
    add_column :events, :voting_enabled, :boolean, :default => true
    add_column :events, :volunteering_enabled, :boolean, :default => true
    add_column :events, :volunteer_end_date, :date
    add_column :events, :description, :text
  end
end
