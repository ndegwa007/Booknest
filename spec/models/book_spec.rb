require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "associations" do
    it { should have_many(:borrowings) }
    it { should have_many(:borrowers).through(:borrowings).source(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:isbn) }
    it { should validate_uniqueness_of(:isbn) }
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array([ 'available', 'borrowed' ]) }
  end

  describe "#available?" do
    let(:available_book) { create(:book, status: 'available') }
    let(:borrowed_book) { create(:book, status: 'borrowed') }

    it "returns true if the book status is 'available'" do
      expect(available_book.available?).to be true
    end

    it "returns false if the book status is 'borrowed'" do
      expect(borrowed_book.available?).to be false
    end
  end

  describe "#mark_as_borrowed!" do
    let(:book) { create(:book, status: 'available') }

    it "updates the book status to 'borrowed'" do
      book.mark_as_borrowed!
      expect(book.status).to eq('borrowed')
    end
  end

  describe "#mark_as_available!" do
    let(:book) { create(:book, status: 'borrowed') }

    it "updates the book status to 'available'" do
      book.mark_as_available!
      expect(book.status).to eq('available')
    end
  end
end
