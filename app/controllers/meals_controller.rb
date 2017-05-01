class MealsController < ApplicationController
  load_and_authorize_resource param_method: :permit_meal
  before_action :authenticate_user!, except: [:show]
  before_action :set_shop
  before_action :set_meal, only: [:show, :edit, :update, :destroy, :change_favorite]

  def show
    @favorite_meal = @meal.favorite_mealships.find_by(user_id: current_user.id) if current_user
  end

  def new
    @meal = @shop.meals.build
  end

  def create
    @meal = @shop.meals.build(permit_meal)
    @meal.user_id = current_user.id

    if @meal.save
      flash[:notice] = "新增成功"
      redirect_to shop_path(@shop)
    else
      flash[:alert] = "新增失敗"
      render :new
    end
  end

  def edit

  end

  def update
    if @meal.update(permit_meal)
      flash[:notice] = "編輯成功"
      redirect_to shop_path(@shop)
    else
      flash[:alert] = "編輯失敗"
      render :edit
    end
  end

  def destroy
    @meal.destroy

    flash[:notice] = "刪除成功"
    redirect_to shop_path(@shop)
  end

  def change_favorite
    if @favorite_meal = @meal.favorite_mealships.find_by(user_id: current_user.id)
      @favorite_meal.destroy
      @favorite_meal = nil
    else
      @favorite_meal = @meal.favorite_mealships.create(user_id: current_user.id)
    end
    redirect_to shop_meal_path(@shop, @meal)
  end

  private

  def set_meal
    @meal = @shop.meals.find(params[:id])
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def permit_meal
    params.require(:meal).permit(:name, :price, { photos: [] }, tag_ids: [])
  end
end
