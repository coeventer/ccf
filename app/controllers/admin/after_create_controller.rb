class Admin::AfterCreateController < Admin::AdminController
  include Wicked::Wizard
  steps :guide, :privacy, :logo, :events, :invitations, :done

  def show
    case step 
    when :invitations
      skip_step if current_organization.auto_verify
    else
    end

    render_wizard
  end

  def update
    skip_step if current_organization.update_attributes(params[:organization])
    
    render_wizard
  end

end
