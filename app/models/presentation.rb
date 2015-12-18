class Presentation < ActiveRecord::Base
  attr_accessible :why, :what, :wrong, :right, :next_steps, :title, :published
  belongs_to :project
  has_one :organization, through: :project
  delegate :id, to: :organization, prefix: true

  before_create :assign_title

  def assign_title
    self.title = project.title if project
  end

end
