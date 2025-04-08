require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  let(:user) { User.create!(email: "user@example.com", password: "password123") }
  let(:book) { Book.create!(title: "Sample Book", author: "John Doe", isbn: "1234567890", status: "available") }

  subject { described_class.new(user: user, book: book) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:book_id).scoped_to(:user_id).with_message("is already borrowed by you") }

    context "when a user borrows the same book twice" do
      before { Borrowing.create!(user: user, book: book) }

      it "does not allow duplicate borrowings for the same user and book" do
        duplicate_borrowing = Borrowing.new(user: user, book: book)
        expect(duplicate_borrowing).not_to be_valid
        expect(duplicate_borrowing.errors[:book_id]).to include("is already borrowed by you")
      end
    end
  end

  describe "callbacks" do
    it "sets due_date before creation" do
      borrowing = Borrowing.create!(user: user, book: book)
      expect(borrowing.due_date).to be_within(1.second).of(2.weeks.from_now)
    end
  end
end
