class BooksController < ApplicationController
  def index
    @books = Book.filter(params.slice(:title, :authors, :publisher, :subject))
    if params[:sort] == "year"
      @books = @books.order(year: :desc)
    # elsif params[:sort] == "review score"
    #   @books = @books.order(average_score: :desc)
    end
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
