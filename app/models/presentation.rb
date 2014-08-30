class Presentation < ActiveRecord::Base
  attr_accessible :why, :what, :wrong, :right, :next_steps
  belongs_to :project
end
