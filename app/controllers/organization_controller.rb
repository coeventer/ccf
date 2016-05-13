class OrganizationController < ApplicationController
  include OrganizationLib
  layout 'organization'
  before_filter :publically_accessible

  def verification_required
    return true if current_user.admin? || current_organization.admin?(current_user) || current_organization.verified?(current_user)
    respond_to do |format|
      format.html do
        redirect_to unverified_path
        return false
      end

      format.json do
        render "organization_home/unverified"
        return false
      end
    end
  end

private

  def publically_accessible
    return true if current_organization.public_access

    auth_required && verification_required
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
    elsif ["likes"].include?(sort)
      @projects = @projects.most_liked
    else
      @projects = @projects.hottest
    end
  end
end
