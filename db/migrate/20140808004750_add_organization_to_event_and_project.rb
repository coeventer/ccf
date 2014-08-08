class AddOrganizationToEventAndProject < ActiveRecord::Migration
  def change
    add_column :events, :organization_id, :integer, default: 0
    add_column :projects, :organization_id, :integer, default: 0
  end
end
