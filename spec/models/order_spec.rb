require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order){FactoryGirl.build :order}
  subject{order}

  it{should respond_to :total}
  it{should respond_to :user_id}
  it{should validate_presence_of :user_id}
  it{should validate_presence_of :total}
  it{should validate_numericality_of(:total).is_greater_than_or_equal_to(0)}

  it{should belong_to :user}

  describe "#build_placements_with_product_ids_and_quantities" do
    before do
      @order = FactoryGirl.create :order
      product1 = FactoryGirl.create :product
      product2 = FactoryGirl.create :product
      @product_ids_and_quantities = [[product1.id, 1], [product2.id, 1]]
    end

    it "builds 2 placements for the order" do
      expect(@order.build_placements_with_product_ids_and_quantities(@product_ids_and_quantities)).to change{@order.placements.size}.from(0).to(2)
    end
  end
end
