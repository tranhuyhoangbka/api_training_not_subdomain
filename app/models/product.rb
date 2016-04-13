class Product < ActiveRecord::Base
  belongs_to :user
  has_many :placements
  has_many :orders, through: :placements

  validates :title, :user, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
end
