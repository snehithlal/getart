class User < ApplicationRecord
  has_one :user_detail, dependent: :destroy
  has_many :products
  
  attr_accessor :password, :confirm_password, :dont_validate_password
  validates_presence_of :email_id
  validates_presence_of :password, if: Proc.new{|user| user.dont_validate_password != false}
  validates_presence_of :confirm_password, if: Proc.new{|user| user.new_record?}
  validate :password_match, if: Proc.new{|user| user.password.present?}
  validates :email_id, uniqueness: { scope: :is_active,
      message: "can have only one active per time." }, if: Proc.new{|user| user.new_record?} #:phone_no
  before_save :hash_password, if: Proc.new{|user| user.dont_validate_password != false}
   
  scope :active, -> { where(is_active: true) }
  
  def authenticate
    user = User.active.where("email_id = ?", self.email_id).first
    if user.present?
      return user.hashed_password == Digest::SHA1.hexdigest(user.password_salt.to_s + self.password)
    end
    return false
  end
  
  def send_otp_by_mail(otp)
    UserMailer.with(user: self, otp: otp).send_otp.deliver_now
  end
  
  def send_password_reset_token_by_mail
    if self.update(reset_password_token: SecureRandom.base64(17).gsub(/[+, =, \/]/,""), dont_validate_password: false)
      UserMailer.with(user: self).send_password_reset_token.deliver_now
    end
  end
  
  def self.minimum_password_length
    false
  end
  
  private
  
    def password_match
      if password != confirm_password
        errors.add(:password, "doesn't match")
      end
    end
    
    def hash_password
      self.password_salt =  SecureRandom.base64(8) if self.password_salt == nil
      self.hashed_password = Digest::SHA1.hexdigest(self.password_salt + self.password)
    end
end
