class BooksController < ApplicationController
  def index
    @books = Book.all # get all books from the database
  end
end
