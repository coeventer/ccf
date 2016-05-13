class AddHotnessToProject < ActiveRecord::Migration
  def change
    add_column :projects, :hotness, :float
  end
end
