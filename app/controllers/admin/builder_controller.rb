class Admin::BuilderController < Admin::AdminController
  include Wicked::Wizard

  before_filter :find_event

  steps :information, :registration, :ideas, :schedule, :logo, :customizations, :publish

  def show
    render_wizard
  end

  def update
    if @event.update_attributes(params[:event])
      skip_step unless step == :publish
    end

    render_wizard
  end

  def find_event
    @event = current_organization.events.find(params[:event_id])
  end

end
