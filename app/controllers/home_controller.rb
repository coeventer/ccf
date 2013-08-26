class HomeController < ApplicationController
  def index
    @future_events = Event.where(["end_date >= ?", Date.today]) 
    @past_events = Event.where(["end_date < ?", Date.today]) 
  end
end
