class User < ApplicationRecord
  attr_accessor :full_name, :password, :confirm_password
  validates_presence_of :password, :email_id#,:full_name, :phone_no
  validates_presence_of :confirm_password, if: Proc.new{|user| user.new_record?}
  validate :password_match, if: Proc.new{|user| user.password.present?}
  validates :email_id, uniqueness: { scope: :is_active,
      message: "can have only one active per time." }, if: Proc.new{|user| user.new_record?} #:phone_no
  # validates :phone_no, numericality: true, length: { minimum: 10, maximum: 10 }
  has_one :user_detail, dependent: :destroy
  after_create :create_user_detail
  before_save :hash_password
  
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
  
  def self.minimum_password_length
    false
  end
  
  private
  
    def password_match
      if password != confirm_password
        errors.add(:password, "Password doesn't match")
      end
    end
    
    def hash_password
      self.password_salt =  SecureRandom.base64(8) if self.password_salt == nil
      self.hashed_password = Digest::SHA1.hexdigest(self.password_salt + self.password)
    end
    
    def create_user_detail
      build_user_detail(full_name: full_name, email_id: email_id, phone_no: phone_no)
      save
    end
end
