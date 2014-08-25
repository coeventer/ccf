class OrganizationController < ApplicationController
  include OrganizationLib
  layout 'organization'
  around_filter :scope_current_organization

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

  private

  def current_ability
    @current_ability ||= Ability.new(current_user, current_organization)
  end

  def sort_projects
    # Check for project sort variable and re-order if needed
    sort = params[:sort].to_s
    if !sort.nil? && ["created_at", "approved desc"].include?(sort) then
      @projects = @projects.order(sort)
    elsif !sort.nil? && ["helpers"].include?(sort)
      @projects = @projects.most_help
    # Default sort, use votes
    elsif !sort.nil? && ["comments"].include?(sort)
      @projects = @projects.most_commented
    else
      @projects = @projects.most_liked
    end
  end
end