require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product){FactoryGirl.build :product}
  subject{product}

  it{should validate_presence_of :title}
  it{should validate_presence_of :price}
  it{should validate_presence_of :user}
  it{should validate_numericality_of(:price).is_greater_than_or_equal_to(0)}
  it{should belong_to :user}
end
