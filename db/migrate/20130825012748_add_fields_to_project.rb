class AddFieldsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :classification, :string
  end
end
