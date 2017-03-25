class ShopsController < ApplicationController
  before_action :set_shop, only: [:edit, :update, :destroy]

  def index
    @shops = Shop.all
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(permit_shop)

    if @shop.save
      flash[:notice] = "新增成功"
      redirect_to shops_path
    else
      flash[:alert] = "新增失敗"
      render :new
    end
  end

  def edit

  end

  def update

    if @shop.update(permit_shop)
      flash[:notice] = "編輯成功"
      redirect_to shops_path
    else
      flash[:alert] = "編輯失敗"
      render :edit
    end
  end

  def destroy
    @shop.destroy

    flash[:notice] = "刪除成功"
    redirect_to shops_path
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def permit_shop
    params.require(:shop).permit(:name, :phone, :address, :rate, :lng, :lat)
  end

end
