require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #show" do
    before do
      @product = FactoryGirl.create :product
      get :show, id: @product, format: :json
      @product_response = JSON.parse response.body
    end

    subject{@product_response["product"]}

    it{is_expected.to eq @product.as_json.except("created_at", "updated_at", "user_id")}
    it{expect(response).to have_http_status(200)}
  end

  describe "GET #index" do
    before do
      @user = FactoryGirl.create :user
      @product1 = FactoryGirl.create :product
      @product2 = FactoryGirl.create :product
      get :index, format: :json
      @response_products = JSON.parse(response.body, symbolize_names: true)
    end
    subject{@response_products[:products].count}
    it{is_expected.to eq 2}
    it{expect(response).to have_http_status 200}
  end

  describe "POST #create" do
    context "when is successfully created" do
      before do
        @user = FactoryGirl.create :user
        @product_attr = FactoryGirl.attributes_for :product
        post :create, {user_id: @user.id, product: @product_attr}, format: :json
      end

      let(:product_response){JSON.parse(response.body, symbolize_names: true)}

      it "renders the json representation for the product record just created" do
        expect(product_response[:product][:title]).to eq @product_attr[:title]
      end
      it{expect(response).to have_http_status(201)}
    end

    context "when is not created" do
      before do
        @user = FactoryGirl.create :user
        @product_attrs = {title: "Manly Closether", price: "opppps"}
        post :create, {user_id: @user.id, product: @product_attrs}, format: :json
      end

      let(:product_response){JSON.parse(response.body, symbolize_names: true)}

      subject{product_response}

      it "renders an errors json" do
        is_expected.to have_key(:errors)
      end

      it "renders the json errors on why the user couldn't be created" do
        expect(product_response[:errors][:price]).to include "is not a number"
      end

      it {expect(response).to have_http_status(422)}
    end
  end

  describe "PATCH #update" do
    let(:user){FactoryGirl.create :user}
    let(:product){FactoryGirl.create :product, user: user}

    context "when is successfully updated" do
      before do
        patch :update, {user_id: user.id, id: product.id, product: {title: "Sweet Candy for grand", price: 100}}, format: :json
      end

      let(:product_response){JSON.parse(response.body, symbolize_names: true)[:product]}
      it{expect(product_response[:title]).to eq "Sweet Candy for grand"}
      it{expect(product_response[:price]).to eq 100}
      it{expect(response).to have_http_status(200)}
    end

    context "when is not updated" do
      before do
        patch :update, {user_id: user.id, id: product.id, product: {price: "fails price"}}
      end

      let(:product_response){JSON.parse(response.body, symbolize_names: true)}
      it{expect(product_response).to have_key(:errors)}
      it{expect(product_response[:errors][:price]).to include "is not a number"}
      it{expect(response).to have_http_status(422)}
    end
  end

  describe "DELETE #destroy" do
    before do
      @user = FactoryGirl.create :user
      @product = FactoryGirl.create :product
    end

    before do
      delete :destroy, {user_id: @user.id, id: @product.id}
    end

    it{expect(@user.products.find_by_id(@product.id)).to be_nil}
    it{expect(response).to have_http_status 204}
  end
end
