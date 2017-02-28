class Admin::BuilderController < Admin::AdminController
  include Wicked::Wizard

  before_filter :find_event

  steps :information, :registration, :ideas, :schedule, :logo, :customizations, :settings, :publish

  def show
    render_wizard
  end

  def update
    if step == :customizations
      @event.update_attributes(customizations: EventCustomization.new(params[:event_customization].symbolize_keys).to_h)
      skip_step
    elsif @event.update_attributes(params[:event])
      skip_step unless step == :publish
    end

    render_wizard
  end

  def find_event
    @event = current_organization.events.find(params[:event_id])
  end

end
