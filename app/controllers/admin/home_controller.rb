class Admin::HomeController < Admin::AdminController
  def index
    @events = Event.all
  end
end
