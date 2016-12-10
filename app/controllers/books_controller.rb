class BooksController < ApplicationController
  def index
    @books = Book.filter(params.slice(:title, :authors, :publisher, :subject)).page(params[:page]).per(24)
    if params[:sort] == "year"
      @books = @books.order(year: :desc)
    elsif params[:sort] == "review score"
      @books = @books.order('average_score DESC NULLS LAST')
    else
      @books = @books.order(created_at: :desc)
    end
  end

  def show
    @book = Book.find(params[:id])
    if params[:num].present?
      @opinions = @book.opinions.includes(:ratings).order('average_usefulness DESC NULLS LAST').limit(params[:num])
    else
      @opinions = @book.opinions.includes(:ratings).page(params[:page]).per(10)
    end
    if params[:recommend].present?
      @recommended = Book.find_by_sql("SELECT books.id, books.title, books.authors FROM books INNER JOIN (manifests INNER JOIN orders ON orders.id = manifests.order_id) ON books.id = manifests.book_id WHERE orders.user_id IN (SELECT orders.user_id FROM manifests, orders WHERE orders.id = manifests.order_id AND orders.user_id <> #{current_user.id} AND manifests.book_id = #{params[:id]}) AND books.id <> #{params[:id]} GROUP BY books.id ORDER BY SUM(manifests.quantity) DESC LIMIT 6")
    end
    if user_signed_in?
      @cart = Cart.new
      @opinion = Opinion.new
    end
  end
end
