class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid
      t.string :deptid
      t.string :department
      t.string :email
      t.string :image
      t.boolean :admin

      t.timestamps
    end
  end
end
