class Message

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :subject, :body, :event

  validates :name, :email, :subject, :body, :presence => true
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def event_title
    return "None" unless event
    
    Event.find_by(id: event).try(:title) || "None"
  end

end
