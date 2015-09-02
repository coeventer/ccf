class Admin::AfterCreateController < Admin::AdminController
  include Wicked::Wizard
  steps :guide, :privacy, :logo, :events, :done

  def show
    render_wizard
  end

  def update
    skip_step if current_organization.update_attributes(params[:organization])

    render_wizard
  end

end
