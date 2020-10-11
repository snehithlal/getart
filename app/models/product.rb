class Product < ApplicationRecord

  belongs_to :user
  belongs_to :category
  belongs_to :medium
  belongs_to :material
  belongs_to :art_era
  
  has_many :product_details
  has_many :stocks, through: :product_details

end
