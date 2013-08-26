class AddRegistrationInformation < ActiveRecord::Migration
  def up
    add_column :events, :registration_end_dt, :date
    add_column :events, :registration_maximum, :integer

    add_column :event_registrations, :note, :text
  end

  def down
  end
end
