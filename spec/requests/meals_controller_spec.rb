require 'rails_helper'

RSpec.describe MealsController, type: :request do
  let!(:user) { create(:user, email: "test@gmail.com") }
  let!(:shop) { create(:shop, user_id: user.id) }
  let!(:tags) { create_list(:meal_tag, 2) }
  let!(:meal) { create(:meal, shop_id: shop.id, user_id: user.id, tag_ids: tags.pluck(:id)) }
  before(:each) { login_user(user) }

  describe "POST /shops/:shop_id/meals" do
    context "create meal success" do
      before(:each) do
        data = {
          "meal" => {
            "name" => "aaa",
            "price" => 1000
          }
        }

        post "/shops/#{shop.id}/meals", params: data
      end

      it{ expect(response).to have_http_status(302) }
      it{ expect(response).to redirect_to(shop_url(shop)) }
      it do
        follow_redirect!
        expect(response).to be_success
        expect(response.body).to include("aaa")
      end

    end

    context "create meal failed" do
      before(:each) { post "/shops/#{shop.id}/meals", params: { "meal" => { "name" => "" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("meals/new") }
      it{ expect(flash[:alert]).to eq("新增失敗") }
      it{ expect(response.body).to include("新增失敗") }
    end
  end

  describe "PATCH /shops/:shop_id/meal/:id" do
    context "update meal success" do
      before(:each) do
        data = {
          "meal" => {
            "name" => "bbb",
          }
        }

        patch "/shops/#{shop.id}/meals/#{meal.id}", params: data
      end

      it{ expect(response).to have_http_status(302) }
      it{ expect(response).to redirect_to(shop_url(shop)) }
      it{ expect(flash[:notice]).to eq("編輯成功") }
      it do
        follow_redirect!
        expect(response).to be_success
        expect(response.body).to include("編輯成功")
      end
    end

    context "update meal failed" do
      before(:each) { patch "/shops/#{shop.id}/meals/#{meal.id}", params: { "meal" => { "name" => "" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("meals/edit") }
    end
  end

  describe "DELETE /shops/:shop_id/meal/:id" do
    before(:each) { delete "/shops/#{shop.id}/meals/#{meal.id}" }

    context "destroy meal success" do
      it{ expect(response).to have_http_status(302) }
      it{ expect(response).to redirect_to(shop_url(shop)) }
      it{ expect(flash[:notice]).to eq("刪除成功") }
      it do
        follow_redirect!
        expect(response).to be_success
        expect(response.body).to include("刪除成功")
      end
    end
  end

  describe "GET /shops/:shop_id/meal/:id" do
    before(:each) { get "/shops/#{shop.id}/meals/#{meal.id}" }

    context "show meal success" do
      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("meals/show") }
      it{ expect(response.body).to include("#{meal.name}") }
      it{ expect(response.body).to include("#{tags.first.name}") }
      it{ expect(response.body).to include("#{tags.last.name}") }
    end
  end

  describe "GET /shops/:shop_id/meal/:id/change_favorite" do

    context "add favorite" do
      before(:each) { post "/shops/#{shop.id}/meals/#{meal.id}/change_favorite" }

      it do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(shop_meal_path(shop, meal))
        follow_redirect!
        expect(response.body).to include("移出我的最愛")
        expect(response).to be_success
      end
    end

    context "remove favorite" do
      before(:each) do
        FavoriteMealship.create(user_id: user.id, meal_id: meal.id)
        post "/shops/#{shop.id}/meals/#{meal.id}/change_favorite"
      end

      it do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(shop_meal_path(shop, meal))
        follow_redirect!
        expect(response.body).to include("加到我的最愛")
        expect(response).to be_success
      end
    end
  end
end
