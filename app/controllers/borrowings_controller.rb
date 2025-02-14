class BorrowingsController < ApplicationController
  # ... existing code ...

  def create
    @book = Book.find(params[:book_id])
    
    if @book.available?
      @borrowing = current_user.borrowings.build(book: @book)
      
      if @borrowing.save
        @book.mark_as_borrowed!
        redirect_to borrowed_books_path, notice: 'Book was successfully borrowed.'
      else
        redirect_to @book, alert: 'Unable to borrow this book.'
      end
    else
      redirect_to @book, alert: 'This book is currently unavailable.'
    end
  end

  def destroy
    @borrowing = current_user.borrowings.find(params[:id])
    @book = @borrowing.book
    
    if @borrowing.destroy
      @book.mark_as_available!
      redirect_to borrowed_books_path, notice: 'Book was successfully returned.'
    else
      redirect_to borrowed_books_path, alert: 'Unable to return this book.'
    end
  end
end 