class Presentation < ActiveRecord::Base
  attr_accessible :why, :what, :wrong, :right, :next_steps, :title, :published
  belongs_to :project

  before_create :assign_title

  def assign_title
    title = project.title if project
  end

end
