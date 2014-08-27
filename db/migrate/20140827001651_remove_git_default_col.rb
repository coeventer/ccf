class RemoveGitDefaultCol < ActiveRecord::Migration
  def change
    change_column :projects, :repository, :string, :default => nil
  end
end
