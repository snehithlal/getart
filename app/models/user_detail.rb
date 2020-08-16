class UserDetail < ApplicationRecord
  belongs_to :user
  validates_presence_of :email_id#, :phone_no, :full_name
end
