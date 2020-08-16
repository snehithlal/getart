class UserDetail < ApplicationRecord
  belongs_to :user
  validates_presence_of :full_name, :email_id, :phone_no
end
