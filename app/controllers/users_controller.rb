class UsersController < ApplicationController
  authorize_resource
  before_action :authenticate_user!

  def show
    @user = current_user || User.find(params[:id])
  end
end
