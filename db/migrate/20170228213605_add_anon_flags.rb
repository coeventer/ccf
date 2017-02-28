class AddAnonFlags < ActiveRecord::Migration
  def change
    add_column :events, :flags, :integer, default: 0, null: false
  end
end
