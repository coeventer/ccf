class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.text :why
      t.text :what
      t.text :right
      t.text :wrong
      t.text :next_steps
      t.integer :project_id

      t.timestamps
    end
  end
end
