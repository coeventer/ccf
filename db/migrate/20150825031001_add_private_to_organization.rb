class AddPrivateToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :public_access, :boolean, default: false
  end
end
