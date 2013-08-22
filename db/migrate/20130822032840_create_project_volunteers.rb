class CreateProjectVolunteers < ActiveRecord::Migration
  def change
    create_table :project_volunteers do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :interest_level

      t.timestamps
    end
  end
end
