class CreateProjectTags < ActiveRecord::Migration
  def change
    create_table :project_tags do |t|
      t.integer :project_id
      t.string :tag

      t.timestamps
    end
  end
end
