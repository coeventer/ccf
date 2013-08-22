class CreateProjectRatings < ActiveRecord::Migration
  def change
    create_table :project_ratings do |t|
      t.integer :project_id
      t.integer :user_id
      t.integer :rating

      t.timestamps
    end
  end
end
