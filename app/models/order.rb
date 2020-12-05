require 'securerandom'
class Order < ApplicationRecord
  belongs_to :user_detail
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products, dependent: :destroy
  before_create :set_slug
  
  private
    def set_slug
      time =Time.now.localtime
      slug = "OD#{time.year}#{time.month}#{time.day}#{(rand(10 ** 10)).to_s.rjust(10, '0')}"
      while(Order.exists?(slug: slug))
        slug = "OD#{time.year}#{time.month}#{time.day}#{(rand(10 ** 10)).to_s.rjust(10, '0')}"
      end
      self.slug = slug
    end
end
