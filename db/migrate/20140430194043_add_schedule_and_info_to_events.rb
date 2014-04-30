class AddScheduleAndInfoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :schedule, :text
    add_column :events, :other_info, :text
  end
end
