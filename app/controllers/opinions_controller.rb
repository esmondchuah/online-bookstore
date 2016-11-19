class OpinionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @opinions = current_user.opinions.all
  end

  def create
    current_user.create_opinion(opinion_params)
    redirect_to :back
  end

  private

  def opinion_params
    params.require(:opinion).permit(:score, :comment, :book_id)
  end
end