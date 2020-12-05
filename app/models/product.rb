class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :medium, optional: true
  belongs_to :material, optional: true
  belongs_to :art_era, optional: true
  has_many :product_details, dependent: :destroy
  has_many :stocks, through: :product_details
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products, dependent: :destroy
  # mount_uploaders :images, ImageUploader
  before_create :set_slug
  
  private
    def set_slug
      time =Time.now.localtime
      slug = "P#{time.year}#{time.month}#{time.day}#{(rand(10 ** 10)).to_s.rjust(10, '0')}"
      while(Product.exists?(slug: slug))
        slug = "P#{time.year}#{time.month}#{time.day}#{(rand(10 ** 10)).to_s.rjust(10, '0')}"
      end
      self.slug = slug
    end
end
