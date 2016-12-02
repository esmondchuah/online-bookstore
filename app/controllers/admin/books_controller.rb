class Admin::BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_rights

  def index
    @books = Book.page(params[:page]).per(25)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to [:admin, @book], notice: 'New book was successfully created.'
    else
      render 'new'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to [:admin, @book], notice: 'Book details were successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_books_path, notice: 'Book was successfully deleted.'
  end

  def stats
    @books = Book.select('books.id, books.title, books.isbn').joins(:orders).from_this_month
  end

  private

  def book_params
    params.require(:book).permit(:isbn, :title, :authors, :publisher, :year, :inventory, :price, :format, :keywords, :subject)
  end

  protected

  def check_admin_rights
    unless current_user.admin?
      redirect_to root_url, alert: "You do not have admin rights."
    end
  end
end
