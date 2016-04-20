class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :published
  has_one :user, serializer: ProductUserSerializer
end
