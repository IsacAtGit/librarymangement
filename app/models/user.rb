class User < ApplicationRecord
  has_many :orders
  has_many :books, through: :orders

  
  validates :name, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :role, inclusion: { in: %w(user admin), message: "%{value} is not a valid role" }
  validates :mobilenumber, format: { with: /\A\d{10}\z/, message: "should be a 10-digit number" }
  validates :password, length: { minimum: 6, message: "should be at least 6 characters long" }
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "should include at least one letter and one digit" }
end
