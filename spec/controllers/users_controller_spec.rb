require 'rails_helper'

#GET #new
# Ensures the registration form is displayed.
#POST #create
# Successfully creates a user with valid parameters.
# Fails when given invalid parameters.
#GET #borrowed_books
# Fetches borrowed books that belong to the authenticated user.
#DELETE #return_book
# Successfully returns a borrowed book and updates the status.
#Fails gracefully if returning is unsuccessful.

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, password: "secure123", password_confirmation: "secure123") }
  let(:book) { create(:book, status: "borrowed") }
  let(:borrowing) { create(:borrowing, user: user, book: book) }

  before do
    session[:user_id] = user.id # Simulating authentication without Devise
  end

  describe "GET #new" do
    it "renders the new user form" do
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) { { user: attributes_for(:user) } }

      it "creates a new user and redirects to root path" do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("User created successfully")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { { user: { email: "", password: "", password_confirmation: "" } } }

      it "does not create a new user and renders the new form again" do
        expect {
          post :create, params: invalid_params
        }.not_to change(User, :count)

        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #borrowed_books" do
    it "retrieves the user's borrowed books" do
      borrowing # Ensure a borrowing exists before making the request

      get :borrowed_books, params: { id: user.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:borrowed_books)).to include(book)
    end
  end

  describe "DELETE #return_book" do
    context "when returning a borrowed book" do
      it "deletes the borrowing record and marks the book as available" do
        borrowing # Ensure the borrowing exists before attempting to return

        expect {
          delete :return_book, params: { id: user.id, book_id: book.id }
        }.to change(Borrowing, :count).by(-1)

        expect(book.reload.status).to eq("available")
        expect(response).to redirect_to(borrowed_books_user_path(user))
        expect(flash[:notice]).to eq("Book has been returned successfully.")
      end
    end

    context "when return fails" do
      it "does not remove the borrowing and shows an alert" do
        allow_any_instance_of(Borrowing).to receive(:destroy).and_return(false)

        delete :return_book, params: { id: user.id, book_id: book.id }
        expect(response).to redirect_to(borrowed_books_user_path(user))
        expect(flash[:alert]).to eq("Unable to return the book.")
      end
    end
  end
end
