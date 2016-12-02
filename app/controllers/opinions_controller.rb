class OpinionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @opinions = current_user.opinions.includes(:book)
  end

  def create
    if current_user.opinions.where(book_id: opinion_params[:book_id]).exists?
      redirect_to :back, notice: "You have already given your review for this book."
    else
      current_user.create_opinion(opinion_params)
      redirect_to :back
    end
  end

  private

  def opinion_params
    params.require(:opinion).permit(:score, :comment, :book_id)
  end
end
