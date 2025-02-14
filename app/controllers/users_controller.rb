class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:borrowed_books, :return_book]
  # show the registration form
  def new
    @user = User.new
  end
  # create a new user
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "User created successfully"
    else
      render :new
    end
  end

  private
  # strong parameters for user registration
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def borrowed_books
    @borrowed_books = current_user.borrowed_books.joins(:borrowings).merge(Borrowing.active)
  end

  def return_book
    borrowing = current_user.borrowings.find(book_id: params[:id])
    if borrowing&.destroy
      redirect_to borrowed_books_user_path(current_user), notice: 'Book returned successfully'
    else
      redirect_to borrowed_books_user_path(current_user), alert: 'Book not found'
    end
  end
end
