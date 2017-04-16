require 'rails_helper'

RSpec.describe ShopsController, type: :request do
  let!(:user) { create(:user, email: "test@gmail.com") }
  let!(:tags) { create_list(:shop_tag, 2) }
  let!(:shop) { create(:shop, user_id: user.id, tag_ids: tags.pluck(:id)) }
  before(:each) { login_user(user) }

  describe "GET /shops" do
    before(:each) { get "/shops" }

    it{ expect(response).to be_success }
    it{ expect(response).to have_http_status(200) }
    it{ expect(response).to render_template("shops/index") }
    it{ expect(response.body).to include("#{shop.name}") }
  end

  describe "POST /shops" do
    context "create shop success" do
      before(:each) do
        data = {
          "shop" => {
            "name" => "aaa",
            "lng" => 121.0,
            "lat" => 25.0
          }
        }

        post "/shops", params: data
      end

      it{ expect(response).to have_http_status(302) }
      it{ expect(response).to redirect_to(shops_url) }
      it do
        follow_redirect!
        expect(response).to be_success
        expect(response.body).to include("aaa")
      end

    end

    context "create shop failed" do
      before(:each) { post "/shops", params: { "shop" => { "name" => "" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("shops/new") }
      it{ expect(flash[:alert]).to eq("新增失敗") }
      it{ expect(response.body).to include("新增失敗") }
    end
  end

  describe "PATCH /shop/:id" do
    context "update shop success" do
      before(:each) do
        data = {
          "shop" => {
            "name" => "bbb",
          }
        }

        patch "/shops/#{shop.id}", params: data
      end

      it{ expect(response).to have_http_status(302) }
      it{ expect(response).to redirect_to(shops_url) }
      it{ expect(flash[:notice]).to eq("編輯成功") }
      it do
        follow_redirect!
        expect(response).to be_success
        expect(response.body).to include("編輯成功")
      end
    end

    context "update shop failed" do
      before(:each) { patch "/shops/#{shop.id}", params: { "shop" => { "name" => "" } } }

      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("shops/edit") }
    end
  end

  describe "DELETE /shop/:id" do
    before(:each) { delete "/shops/#{shop.id}" }

    context "destroy shop success" do
      it{ expect(response).to have_http_status(302) }
      it{ expect(response).to redirect_to(shops_url) }
      it{ expect(flash[:notice]).to eq("刪除成功") }
      it do
        follow_redirect!
        expect(response).to be_success
        expect(response.body).to include("刪除成功")
      end
    end
  end

  describe "GET /shop/:id" do
    let!(:meal) { create(:meal, shop_id: shop.id) }
    before(:each) { get "/shops/#{shop.id}" }

    context "show shop success" do
      it{ expect(response).to be_success }
      it{ expect(response).to have_http_status(200) }
      it{ expect(response).to render_template("shops/show") }
      it{ expect(response.body).to include("#{shop.name}") }
      it{ expect(response.body).to include("#{meal.name}") }
      it{ expect(response.body).to include("#{tags.first.name}") }
      it{ expect(response.body).to include("#{tags.last.name}") }
    end
  end
end
