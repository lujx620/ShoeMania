class Product < ActiveRecord::Base
  belongs_to :user
  has_many :buyers, dependent: :destroy
  has_many :sells, dependent: :destroy
  has_many :users_bought, through: :buyers, source: :user
  has_many :users_sold, through: :sells, source: :user
  validates :name, :price, presence: true
end
