class AddParticipationLevelToRegistration < ActiveRecord::Migration
  def change
    add_column :event_registrations, :participation_level, :string
  end
end
