class AddEventLogoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_logo, :string
  end
end
