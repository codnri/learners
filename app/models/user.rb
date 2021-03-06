class User < ApplicationRecord
  before_save {self.email = self.email.downcase}
  
  has_many :subjects
  has_secure_password

  validates :password,  presence: true,length: { minimum: 6 },allow_nil: true 
  #"allow_nil: true" avoids the validation of has_secure_password when the password is nil
    
  validates :lastname, presence: true,length: { maximum: 50 }
  validates :firstname, presence: true,length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
    format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  
  validates :admin, default: false
  
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  
  def full_name
    self.firstname + " " + self.lastname
  end
  
end
