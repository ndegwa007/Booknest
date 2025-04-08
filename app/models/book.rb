class Book < ApplicationRecord
    has_many :borrowings
    has_many :borrowers, through: :borrowings, source: :user
    validates :title, :author, :isbn, presence: true
    validates :isbn, uniqueness: true
    validates :status, presence: true, inclusion: { in: [ "available", "borrowed" ] }

    def available?
        status == "available"
    end

    def mark_as_borrowed!
        update(status: "borrowed")
    end

    def mark_as_available!
        update(status: "available")
    end
end
