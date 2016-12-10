class Admin::BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_rights

  def index
    @books = Book.filter(params.slice(:title, :authors, :publisher, :subject)).page(params[:page]).per(25)
    if params[:sort] == "year"
      @books = @books.order(year: :desc)
    elsif params[:sort] == "inventory"
      @books = @books.order(inventory: :desc)
    else
      @books = @books.order(title: :asc)
    end
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
    @books = Book.select('books.id, books.title, books.isbn, SUM(manifests.quantity) AS num_of_copies').joins('INNER JOIN manifests ON books.id = manifests.book_id').joins('INNER JOIN orders ON orders.id = manifests.order_id').group('books.id').from_this_month.order('SUM(manifests.quantity) DESC')
    if params[:book_num].present?
      @books = @books.limit(params[:book_num])
    else
      @books = @books.limit(10)
    end

    @authors = Book.select('books.authors, SUM(manifests.quantity) AS num_of_copies').joins('INNER JOIN manifests ON books.id = manifests.book_id').joins('INNER JOIN orders ON orders.id = manifests.order_id').group('books.authors').from_this_month.order('SUM(manifests.quantity) DESC')
    if params[:author_num].present?
      @authors = @authors.limit(params[:author_num])
    else
      @authors = @authors.limit(10)
    end

    @publishers = Book.select('books.publisher, SUM(manifests.quantity) AS num_of_copies').joins('INNER JOIN manifests ON books.id = manifests.book_id').joins('INNER JOIN orders ON orders.id = manifests.order_id').group('books.publisher').from_this_month.order('SUM(manifests.quantity) DESC')
    if params[:publisher_num].present?
      @publishers = @publishers.limit(params[:publisher_num])
    else
      @publishers = @publishers.limit(10)
    end
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
