class User < ActiveRecord::Base
  has_many :products
  has_many :buyers, dependent: :destroy
  has_many :sells, dependent: :destroy
  has_many :products_sold, through: :sells, source: :product
  has_many :products_purchases, through: :buyers, source: :product


  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, length: { in: 2..20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  has_secure_password
  before_save :email_downcase

  def email_downcase
    self.email.downcase
  end
end
