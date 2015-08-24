class Admin::BuilderController < Admin::AdminController
  include Wicked::Wizard

  before_filter :find_event

  steps :registration, :ideas, :schedule, :logo, :publish, :published

  def show
    render_wizard
  end

  def update
    skip_step if @event.update_attributes(params[:event])
    
    render_wizard
  end

  def find_event
    @event = current_organization.events.find(params[:event_id])
  end

end
