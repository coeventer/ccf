class AddTimeZoneToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :time_zone, :string, default: 'Central Time (US & Canada)'
  end
end
