class User < ApplicationRecord
    has_secure_password # adds password encryption and authentication
    has_many :borrowings
    has_many :borrowed_books, through: :borrowings, source: :book
    validates :email, presence: true, uniqueness: {case_sensitive: false}
end
