class AddDisplayName < ActiveRecord::Migration
  def change
    add_column :event_registrations, :name, :string
  end
end
