class RatingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ratings = current_user.ratings.all
    @map = ["Useless", "Useful", "Very useful"]
  end

  def create
    if current_user = Opinion.find(params[:opinion_id]).user
      redirect_to :back, notice: "You are not allowed to rate your own review."
    elsif current_user.ratings.where(opinion_id: params[:opinion_id]).exists?
      redirect_to :back, notice: "You are only allowed to rate a review once."
    else
      current_user.create_rating(params[:usefulness], params[:opinion_id])
    end
  end
end
