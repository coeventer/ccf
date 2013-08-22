class HomeController < ApplicationController
  def index
    @project = Project.new
  end
end
