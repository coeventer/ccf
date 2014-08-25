module OrganizationLib
  def self.included(base)
    base.before_filter :find_events
    base.helper_method :current_organization
  end

  def current_organization
    Organization.find_by_subdomain request.subdomain
  end

  def find_events
    @future_events = Event.live.where(["end_date >= ?", Date.today]) 
    @past_events = Event.live.where(["end_date < ?", Date.today]) 
  end

end