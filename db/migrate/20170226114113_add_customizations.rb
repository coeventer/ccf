class AddCustomizations < ActiveRecord::Migration
  def up
    add_column :events, :customizations, :text
    EventCustomization.seed
  end

  def down
    remove_column :events, :customizations
  end
end
