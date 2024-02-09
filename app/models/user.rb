class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :books, through: :orders

  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'Invalid email format' }
  validates :name, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :mobilenumber, format: { with: /\A\d{10}\z/, message: "should be a 10-digit number" }
  validates :password, length: { minimum: 6, message: "should be at least 6 characters long" }
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "should include at least one letter and one digit" }
end
