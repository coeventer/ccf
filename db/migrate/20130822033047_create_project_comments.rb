class CreateProjectComments < ActiveRecord::Migration
  def change
    create_table :project_comments do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
