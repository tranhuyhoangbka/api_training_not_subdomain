class Placement < ActiveRecord::Base
  belongs_to :order, inverse_of: :placements
  belongs_to :product, inverse_of: :placements

  after_create :decrement_product_quantity

  delegate :title, :price, to: :product

  private
  def decrement_product_quantity
    self.product.decrement! :quantity, quantity
  end
end
