class EventRegistration < ActiveRecord::Base
  attr_accessible :event_id, :user, :not
  
  belongs_to :event
  belongs_to :user
  
  validates :user_id, :uniqueness => {:scope => :event_id}
  
  def self.to_csv
    CSV.generate do |csv|
      csv << ["Name", "Email", "Registered On"]
      all.each do |registration|
        csv << [registration.user.name, registration.user.email, registration.created_at]
      end
    end
  end  
end
