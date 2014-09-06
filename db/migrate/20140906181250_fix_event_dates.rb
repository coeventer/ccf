class FixEventDates < ActiveRecord::Migration
  def up
    change_column :events, :start_date, :datetime
    change_column :events, :end_date, :datetime
    change_column :events, :voting_end_date, :datetime
    change_column :events, :volunteer_end_date, :datetime
    change_column :events, :registration_end_dt, :datetime
  end

  def down
    change_column :events, :start_date, :date
    change_column :events, :end_date, :date
    change_column :events, :voting_end_date, :date
    change_column :events, :volunteer_end_date, :date
    change_column :events, :registration_end_dt, :date
  end
end
