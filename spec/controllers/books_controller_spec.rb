require 'rails_helper'

# Uses FactoryBot to create user and book
# Tests index action for correct book retrieval and rendering
# Ensures borrow requires authentication
# Simulates borrowing success and failure scenarios

RSpec.describe BooksController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe "GET #index" do
    it "assigns all books to @books" do
      book1 = create(:book)
      book2 = create(:book)

      get :index
      expect(assigns(:books)).to match_array([ book1, book2 ])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "POST #borrow" do
    context "when user is not authenticated" do
      it "redirects to login page" do
        post :borrow, params: { id: book.id }
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to match(/You need to log in to access this page/)
      end
    end

    context "when user is authenticated" do
      before { session[:user_id] = user.id } # Manually simulate login

      it "borrows a book successfully" do
        expect {
          post :borrow, params: { id: book.id }
        }.to change(Borrowing, :count).by(1)

        expect(response).to redirect_to(borrowed_books_user_path(user))
        expect(flash[:notice]).to eq("Book borrowed successfully")
      end

      it "redirects with an error if borrowing fails" do
        allow_any_instance_of(Borrowing).to receive(:save).and_return(false) # Simulate failure
        allow_any_instance_of(Borrowing).to receive_message_chain(:errors, :full_messages).and_return([ "Something went wrong" ])

        post :borrow, params: { id: book.id }
        expect(response).to redirect_to(books_path)
        expect(flash[:alert]).to eq("Something went wrong")
      end
    end
  end
end
