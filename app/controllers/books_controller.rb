class BooksController < ApplicationController
  def index
    @books = Book.filter(params.slice(:title, :authors, :publisher, :subject)).page(params[:page]).per(24)
    if params[:sort] == "year"
      @books = @books.order(year: :desc)
    elsif params[:sort] == "review score"
      @books = @books.order('average_score DESC NULLS LAST')
    end
  end

  def show
    @book = Book.find(params[:id])
    if params[:num].present?
      @opinions = @book.opinions.order('average_usefulness DESC NULLS LAST').limit(params[:num])
    else
      @opinions = @book.opinions.page(params[:page]).per(10)
    end
    if user_signed_in?
      @cart = Cart.new
      @opinion = Opinion.new
    end
  end
end
