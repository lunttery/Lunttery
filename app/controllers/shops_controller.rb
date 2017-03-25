class ShopsController < ApplicationController

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

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def permit_shop
    params.require(:shop).permit(:name, :phone, :address, :rate, :lng, :lat)
  end

end
