class EnoughProductsValidator < ActiveModel::Validator
  def validate record
    record.placements.each do |pa|
      product = pa.product
      if pa.quantity > product.quantity
        record.errors["#{product.title}"] << "Is out of stock, just #{product.quantity} left"
      end
    end
  end
end