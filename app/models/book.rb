class Book < ApplicationRecord
    has_many: borrowings
    has_many: borrowers, through: :borrowings, source: :user
    validates: :title, :author, :isbn, presence: true
    validates: isbn, uniqueness: true
end
