require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){FactoryGirl.build :user}
  subject{user}

  it{should have_many :products}

  describe "#products association" do
    before do
      @user = FactoryGirl.create :user
      3.times{FactoryGirl.create :product, user: user}
    end

    it "destroys the associated products on self destruct" do
      products = @user.products
      @user.destroy
      products.each do |p|
        it{expect(Product.find(p.id)).to raise_error ActiveRecord::RecordNotFound}
      end
    end
  end
end
