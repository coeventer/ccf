class OrganizationController < ApplicationController
  layout 'organization'
  around_filter :scope_current_organization
  before_filter :find_events

  def current_organization
    Organization.find_by_subdomain! request.subdomain
  end
  helper_method :current_organization

  def find_events
    @future_events = Event.live.where(["end_date >= ?", Date.today]) 
    @past_events = Event.live.where(["end_date < ?", Date.today]) 
  end

  def verification_required
    return true if current_organization.verified?(current_user)
    redirect_to unverified_path and return false
  end

private

  def scope_current_organization
    Organization.current_id = current_organization.id
    yield
  ensure
    Organization.current_id = nil
  end
end