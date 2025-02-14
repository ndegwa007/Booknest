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

  def borrowed_books
      # Fetch active borrowings for the current user
      active_borrowings = current_user.borrowings.active
    
      # Fetch the books associated with the active borrowings
      @borrowed_books = Book.joins(:borrowings).where(borrowings: { id: active_borrowings.pluck(:id) })
    
  end

  def return_book
    @book = Book.find(params[:book_id])
    borrowing = current_user.borrowings.find_by(book: @book)
    
    if borrowing&.destroy
      flash[:notice] = "Book successfully returned"
    else
      flash[:alert] = "Could not return the book"
    end
    
    redirect_to borrowed_books_user_path(current_user)
  end

  private
  # strong parameters for user registration
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  
end
