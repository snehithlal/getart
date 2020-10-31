class UserDetail < ApplicationRecord
  belongs_to :user
  validates_presence_of :email_id#, :phone_no, :full_name
  has_attached_file :avatar, default_url: "user-icons/common.svg"
end
