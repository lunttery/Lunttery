class UsersController < ApplicationController
  authorize_resource
  before_action :authenticate_user!

  def show
    @user = current_user || User.find(params[:id])
  end

  def favorite_meals
    @favorite_meals = current_user.favorite_meals.page(params[:page]).per(10)
  end
end
