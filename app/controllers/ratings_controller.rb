class RatingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ratings = current_user.ratings.all
    @map = ["Useless", "Useful", "Very useful"]
  end

  def create
    current_user.create_rating(params[:usefulness], params[:opinion_id])
  end
end