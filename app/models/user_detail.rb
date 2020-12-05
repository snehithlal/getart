class UserDetail < ApplicationRecord
  belongs_to :user
  has_attached_file :avatar, default_url: "user-icons/common.svg"
  has_many :orders
  has_many :buy_order_products, class_name: "OrderProduct", foreign_key: :buyer_id
  has_many :buy_products, through: :buy_order_products, source: :product
  has_many :selling_order_products, class_name: "OrderProduct", foreign_key: :seller_id
  has_many :selling_products, through: :selling_order_products, source: :product
  has_many :addresses
  delegate :email_id, to: :user
  
  validates_presence_of :phone_no, :full_name
  validates :phone_no, numericality: true, length: { minimum: 10, maximum: 10 }
  after_create :update_phone_no_or_email_id
  
  def user_order_products_by_type(type = nil, page = nil)
    order_products = case type
      when "cancelled"
        buy_order_products.where(is_canceled: true)
      when "returns"
        buy_order_products.where(is_return: true)
      else
        buy_order_products.where(is_canceled: false)
        # buy_order_products.where(is_canceled: false, is_return: false)
      end
    order_products
  end
  
  private
    def update_phone_no_or_email_id
      self.user.update(phone_no: self.phone_no, dont_validate_password: false)
    end
end
