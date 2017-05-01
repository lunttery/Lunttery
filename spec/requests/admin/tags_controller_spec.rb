require 'rails_helper'

RSpec.describe Admin::TagsController, type: :request do
  let!(:shop_tag){ create(:shop_tag) }
  let!(:meal_tag){ create(:meal_tag) }
  let(:create_data) do
    {
      "tag" => {
        "name" => "aaa",
        "source_type" => "Shop"
      }
    }
  end
  let(:update_data) do
    {
      "tag" => {
        "name" => "bbb",
      }
    }
  end
  context "not login" do
    it do
      expect{ get "/admin/tags" }.to raise_error(ActionController::RoutingError)
      expect{ post "/admin/tags", params: create_data }.to raise_error(ActionController::RoutingError)
      expect{ patch "/admin/tags/#{shop_tag.id}", params: update_data }.to raise_error(ActionController::RoutingError)
      expect{ delete "/admin/tags/#{shop_tag.id}" }.to raise_error(ActionController::RoutingError)
    end
  end

  context "is not admin" do
    let(:user) { create(:user) }
    before{ login_user(user) }

    it do
      expect{ get "/admin/tags" }.to raise_error(ActionController::RoutingError)
      expect{ post "/admin/tags", params: create_data }.to raise_error(ActionController::RoutingError)
      expect{ patch "/admin/tags/#{shop_tag.id}", params: update_data }.to raise_error(ActionController::RoutingError)
      expect{ delete "/admin/tags/#{shop_tag.id}" }.to raise_error(ActionController::RoutingError)
    end
  end

  context "is admin" do
    let(:admin) { create(:admin) }
    before{ login_user(admin) }

    describe "GET /admin/tags" do
      before{ get "/admin/tags" }

      it do
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response).to render_template("admin/tags/index")
        expect(response.body).to include("#{shop_tag.name}")
        expect(response.body).to include("#{meal_tag.name}")
      end
    end

    describe "POST /admin/tags" do
      context "create tag success" do
        before{ post "/admin/tags", params: create_data }

        it do
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(admin_tags_url)
          follow_redirect!
          expect(response).to be_success
          expect(response.body).to include("aaa")
        end

      end

      context "create tag failed" do
        before{ post "/admin/tags", params: { "tag" => { "name" => "" } } }

        it do
          expect(response).to be_success
          expect(response).to have_http_status(200)
          expect(response).to render_template("admin/tags/new")
          expect(flash[:alert]).to eq("新增失敗")
          expect(response.body).to include("新增失敗")
        end
      end
    end

    describe "PATCH /admin/tag/:id" do
      context "update tag success" do
      before{ patch "/admin/tags/#{shop_tag.id}", params: update_data }

        it do
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(admin_tags_url)
          expect(flash[:notice]).to eq("編輯成功")
          follow_redirect!
          expect(response).to be_success
          expect(response.body).to include("編輯成功")
          expect(response.body).to include("bbb")
        end
      end

      context "update tag failed" do
        before{ patch "/admin/tags/#{shop_tag.id}", params: { "tag" => { "name" => "" } } }

        it do
          expect(response).to be_success
          expect(response).to have_http_status(200)
          expect(response).to render_template("tags/edit")
        end
      end
    end

    describe "DELETE /admin/tag/:id" do
      before{ delete "/admin/tags/#{shop_tag.id}" }

      context "destroy tag success" do
        it do
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(admin_tags_url)
          expect(flash[:notice]).to eq("刪除成功")
          follow_redirect!
          expect(response).to be_success
          expect(response.body).to include("刪除成功")
          expect(response.body).not_to include(shop_tag.name)
        end
      end
    end
  end
end
