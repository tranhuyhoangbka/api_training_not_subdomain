require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe "GET #index" do
    let(:user){FactoryGirl.create :user}
    let(:product1){FactoryGirl.create :product, user: user}
    let(:product2){FactoryGirl.create :product, user: user}
    let(:order){FactoryGirl.create :order}
    let(:product_ids_and_quantities){["#{product1.id},1", "#{product2.id},1"]}

    before do
      order.build_placements_with_product_ids_and_quantities product_ids_and_quantities
      order.save
      order.reload
      get :index, user_id: order.user.id, auth_token: order.user.auth_token, page: 1, per_page: 2, format: :json
    end

    let(:orders_response){JSON.parse(response.body, symbolize_names: true)}

    it "has 1 orders" do
      expect(orders_response[:orders].count).to eq 1
    end

    it_behaves_like "paginated list" do
      let(:hash_response){orders_response}
    end

    it{expect(response).to have_http_status 200}
  end
end
