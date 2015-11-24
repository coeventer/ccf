module OrganizationLib
  def self.included(base)
    base.before_filter :find_events
    base.helper_method :current_organization
    base.around_filter :scope_current_organization
    base.around_filter :set_time_zone
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

  def set_time_zone(&block)
    time_zone = current_organization.try(:time_zone) || 'Central Time (US & Canada)'
    Time.use_zone(time_zone, &block)
  end

end
