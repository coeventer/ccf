class HomeController < ApplicationController
  def index
    @event = Event.last
  end
end
