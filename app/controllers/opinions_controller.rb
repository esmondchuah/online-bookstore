class OpinionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @opinions = current_user.opinions.includes(:book).page(params[:page]).per(25)
    if params[:sort] == "book title"
      @opinions = @opinions.joins('INNER JOIN books ON books.id = opinions.book_id').order('books.title')
    elsif params[:sort] == "score"
      @opinions = @opinions.order(score: :desc)
    else
      @opinions = @opinions.order(created_at: :desc)
    end
  end

  def create
    if current_user.opinions.where(book_id: opinion_params[:book_id]).exists?
      redirect_back fallback_location: root_url, alert: "You have already given your review for this book."
    else
      current_user.create_opinion(opinion_params)
      redirect_back fallback_location: root_url, notice: "Your review was successfully added."
    end
  end

  private

  def opinion_params
    params.require(:opinion).permit(:score, :comment, :book_id)
  end
end
