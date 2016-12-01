class BooksController < ApplicationController
  def index
    @books = Book.filter(params.slice(:title, :authors, :publisher, :subject))
  end

  def show
    @book = Book.find(params[:id])
    @cart = Cart.new
    @opinions = @book.opinions.all
    if user_signed_in?
      @opinion = Opinion.new
    end
  end
end
