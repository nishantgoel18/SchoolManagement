class User < ApplicationRecord

  include BCrypt

  attr_accessor :password
  validates_presence_of :name

  validates :password, length: (6..32), confirmation: true, if: :setting_password?

  validates :email, presence: true, uniqueness: {case_sensitive: false}
    
  before_create :set_authentication_token
  before_save { email.downcase! }
  before_save :set_password_digest
  

  def is_admin?
    self.type == 'Admin'
  end

  def is_school_admin?
    self.type == 'SchoolAdmin'
  end

  def is_student?
    self.type == 'Student'
  end

  def set_password_digest
    if self.valid? && password.present?
      self.password_digest = Password.create(password)
    end
  end

  def authenticate?(entered_password)
    entered_password.present? && self.password_digest.present? && Password.new(self.password_digest) == entered_password
  end
  
  def set_authentication_token
    self.authentication_token = generate_token_for(:authentication_token)
  end
  
  private
  def setting_password?
    if self.persisted?
      self.password.present?
    else
      true
    end
  end

  def generate_token_for(field)
    loop do
      token = SecureRandom.hex(15)
      break token unless User.where(field => token).exists?
    end
  end
end
