class UsersController < ApplicationController
  before_filter :verification_required
  def show
    @user = User.find(params[:id])
  end
end
