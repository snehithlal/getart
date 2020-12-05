class OrderProduct < ApplicationRecord
  belongs_to :buyer, class_name: "UserDetail", foreign_key: :buyer_id
  belongs_to :seller, class_name: "UserDetail", foreign_key: :buyer_id
  belongs_to :order
  belongs_to :product
end
