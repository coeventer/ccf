class Admin::HomeController < Admin::AdminController
  def index
    @events = current_organization.events.all
  end
end
