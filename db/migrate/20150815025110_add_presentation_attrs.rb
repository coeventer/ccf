class AddPresentationAttrs < ActiveRecord::Migration
  def up
    add_column :presentations, :published, :boolean
    add_column :presentations, :title, :string

    Project.unscoped.all.each do |p|
      p.presentation.update_attributes(title: p.title)
    end
  end

  def down
    remove_column :presentations, :published
    remove_column :presentations, :title
  end
end
