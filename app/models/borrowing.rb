# app/models/borrowing.rb
class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :active, -> { where("due_date > ?", Time.current) }

  # Ensure a book cannot be borrowed more than once
  validates :book_id, uniqueness: { scope: :user_id, message: "is already borrowed by you" }

  # Set due date to 2 weeks from borrowing date
  before_create :set_due_date

  private

  def set_due_date
    self.due_date = 2.weeks.from_now
  end
end
