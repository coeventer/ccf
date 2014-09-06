class AddOrganizationLogoToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :organization_logo, :string
  end
end
