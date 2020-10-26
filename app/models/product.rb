class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :medium, optional: true
  belongs_to :material, optional: true
  belongs_to :art_era, optional: true
  has_many :product_details
  has_many :stocks, through: :product_details
  mount_uploaders :images, ImageUploader
end
