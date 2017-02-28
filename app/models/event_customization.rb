class EventCustomization
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :submit_idea, :repository, :proposed_ideas
  
  def initialize(attributes = {})
    attributes.slice(*self.class.defaults.keys).each do |name, value|
      send("#{name}=", value)
    end
  end

  def to_h
    self.class.defaults.keys.each_with_object({}) do |k, h|
      h[k] = send(k) || self.class.defaults[k]
    end
  end

  def self.defaults
    {
      submit_idea: 'Submit An Idea',
      proposed_ideas: 'Proposed Project Ideas',
      repository: 'Repository'
    }
  end

  def self.seed
    Event.unscoped.all.each do |event|
      event.update_attributes(customizations: defaults)
    end
  end

  def persisted?
    false
  end
end
