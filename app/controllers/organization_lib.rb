module OrganizationLib
  def self.included(base)
    base.around_filter :scope_current_organization
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

  def scope_current_organization
    Organization.current_id = current_organization.id if current_organization
    yield
  ensure
    Organization.current_id = nil
  end

end