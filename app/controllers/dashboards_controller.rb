class DashboardsController < OrganizationController
  skip_before_filter :auth_required

  def show
    @event = Event.find(params[:event_id])
    @recent_activities = RecentActivities.new(@event.id).all
    redirect_to event_path(@event) unless @event.dashboard_enabled
  end
end