class UserDetail < ApplicationRecord
  belongs_to :user, optional: true
  has_attached_file :avatar, default_url: "user-icons/common.svg"
  delegate :email_id, to: :user
  
  validates_presence_of :phone_no, :full_name
  validates :phone_no, numericality: true, length: { minimum: 10, maximum: 10 }
  after_create :update_phone_no_or_email_id
  
  private
    def update_phone_no_or_email_id
      self.user.update(phone_no: self.phone_no, dont_validate_password: false)
    end
end
