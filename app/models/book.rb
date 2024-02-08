class Book < ApplicationRecord

  has_many :orders
  has_many :users, through: :orders

  
  validates :title,format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :description,format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :stock, numericality: { less_than_or_equal_to: 5, message: " must be less than or equal to 5" }
  validates :price, numericality: { greater_than_or_equal_to: 1, message: " must be greater than or equal to 1" }
  validates :isbn, format: { with: /\A\d{10}\z/, message: "should be a 10-digit number" }

  GENRE_OPTIONS = ['fiction', 'non-fiction', 'science fiction', 'mystery', 'anime',"fantasy"].freeze

  validates :genre, inclusion: { in: GENRE_OPTIONS, message: "is not a valid genre" }
  validates :author_id, numericality: { greater_than_or_equal_to: 1, message: " must be greater than or equal to 1" }


end
