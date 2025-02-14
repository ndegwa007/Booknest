class BooksController < ApplicationController

  before_action :authenticate_user!, only: [:borrow]

  def index
    @books = Book.all # get all books from the database
  end

  def borrow
    @book = Book.find(params[:id])
    borrowing  = current_user.borrowings.new(book: @book)

    if borrowing.save
      redirect_to borrowed_books_user_path(current_user), notice: 'Book borrowed successfully'
    
    else
      redirect_to book_path, alert: borrowing.errors.full_messages.join(', ')
    end
  end
end
