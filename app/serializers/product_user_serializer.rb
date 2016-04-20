class ProductUserSerializer < UserSerializer
  def include_products?
    false
  end
end
