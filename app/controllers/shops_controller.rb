class ShopsController < ApplicationController
  load_and_authorize_resource param_method: :permit_shop
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  def index
    @shops = Shop.all.page(params[:page]).per(10)
  end

  def show
    @meals = @shop.meals.page(params[:page]).per(10)
  end

  def new
    @shop = current_user.shops.build
  end

  def create
    @shop = current_user.shops.build(permit_shop)

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

  def search
    keyword = params[:search]
    token = Rails.application.config_for(:google)["token"]
    url = URI.encode("https://maps.googleapis.com/maps/api/place/textsearch/json?language=zh-TW&query=#{keyword}&key=#{token}")
    doc = RestClient.get url
    @shops = JSON.parse(doc)["results"]
    @shops.map! do |shop|
       { address: shop["formatted_address"], lat: shop["geometry"]["location"]["lat"], lng: shop["geometry"]["location"]["lng"], name: shop["name"], rate: shop["rating"]}
    end
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def permit_shop
    params.require(:shop).permit(:name, :phone, :address, :rate, :lng, :lat, tag_ids: [])
  end

end
