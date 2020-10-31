class ProductDetail < ApplicationRecord

  belongs_to :product
  belongs_to :size
  has_many :stocks

end
