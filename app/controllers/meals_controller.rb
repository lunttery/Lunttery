class MealsController < ApplicationController
  load_and_authorize_resource param_method: :permit_meal
  before_action :authenticate_user!, except: [:show]
  before_action :set_shop
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  def show

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
