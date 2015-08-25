class AddCountersToEvents < ActiveRecord::Migration
  def up
    add_column :projects, :project_comments_count, :integer, default: 0
    add_column :projects, :project_ratings_count, :integer, default: 0
    add_column :projects, :project_volunteers_count, :integer, default: 0

    # Project.all.each do |p|
    #   #Project.reset_counters(p.id, :project_comments)
    #   #Project.reset_counters(p.id, :project_ratings)
    #   #Project.reset_counters(p.id, :project_volunteers)
    #   p.comments.each do
    #     Project.update_counters(p.id, :project_comments_count => 1)
    #   end

    #   p.ratings.each do
    #     Project.update_counters(p.id, :project_ratings_count => 1)
    #   end

    #   p.volunteers.each do
    #     Project.update_counters(p.id, :project_volunteers_count => 1)
    #   end
    # end
  end

  def down
    remove_column :projects, :project_comments_count
    remove_column :projects, :project_ratings_count
    remove_column :projects, :project_volunteers_count
  end
end
