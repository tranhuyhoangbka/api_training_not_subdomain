class ProductSerializer < ActiveModel::Serializer
  cached

  attributes :id, :title, :price, :published
  has_one :user, serializer: ProductUserSerializer

  def cache_key
    [object, scope]
  end
end
