class Order < ActiveRecord::Base
  belongs_to :user
  has_many :placements
  has_many :products, through: :placements

  validates :user_id, presence: true
  validates :total, presence: true, numericality: {greater_than_or_equal_to: 0}

  before_validation :set_total!

  private
  def set_total!
    self.total = products.map(&:price).sum
  end
end
