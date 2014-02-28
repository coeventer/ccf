class HomeController < ApplicationController
  skip_before_filter :auth_required
  def index
  end
end
