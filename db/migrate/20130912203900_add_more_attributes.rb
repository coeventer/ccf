class AddMoreAttributes < ActiveRecord::Migration
  def up
    add_column :events, :live, :boolean, :default => false
    add_column :projects, :approved, :boolean, :default => false
    add_column :projects, :repository, :string, :default => "http://github.umn.edu/exam/ple.git"
  end

  def down
    remove_column :events, :live
    remove_column :projects, :approved
    remove_column :projects, :repository
  end
end
