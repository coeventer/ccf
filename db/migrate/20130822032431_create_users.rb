class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :x500id
      t.string :deptid
      t.string :department
      t.string :email
      t.boolean :admin

      t.timestamps
    end
  end
end
