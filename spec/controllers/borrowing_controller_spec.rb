require 'rails_helper'

RSpec.describe BorrowingsController, type: :controller do
  let(:user) { create(:user) }
  let(:available_book) { create(:book, status: 'available') }
  let(:borrowed_book) { create(:book, status: 'borrowed') }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe "POST #create" do
    context "when the book is available" do
      it "creates a new borrowing and marks the book as borrowed" do
        expect {
          post :create, params: { book_id: available_book.id }
        }.to change(Borrowing, :count).by(1)

        expect(available_book.reload.status).to eq('borrowed')
        expect(response).to redirect_to(borrowed_books_user_path(user))
        expect(flash[:notice]).to eq('Book was successfully borrowed.')
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:borrowing) { create(:borrowing, user: user, book: borrowed_book) }

    it "deletes the borrowing and marks the book as available" do
      expect {
        delete :destroy, params: { id: borrowing.id }
      }.to change(Borrowing, :count).by(-1)

      expect(borrowed_book.reload.status).to eq('available')
      expect(response).to redirect_to(borrowed_books_user_path(user))
      expect(flash[:notice]).to eq('Book was successfully returned.')
    end
  end
end
