class Admin::HomeController < Admin::AdminController
  def index
    @event = Event.live.future.first
  end
end
