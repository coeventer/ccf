class AddProjectSubmittedBy < ActiveRecord::Migration
  def up
    add_column :projects, :submitted_user_id, :integer

    Project.unscoped.all.each do |p|
      p.update_attributes(submitted_user_id: p.project_owner_id)
    end
  end

  def down
    remove_column :projects, :submitted_user_id
  end
end
