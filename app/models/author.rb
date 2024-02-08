class Author < ApplicationRecord
    validates :first_name,format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
    validates :last_name, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
end
