class HomeController < ApplicationController
  skip_before_filter :auth_required, :except => [:unverified]
  def index
  end

  def unverified
    redirect_to root_path if current_user.verified?
    @user = current_user
  end
end
