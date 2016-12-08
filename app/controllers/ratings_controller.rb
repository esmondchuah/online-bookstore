class RatingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ratings = current_user.ratings.includes(:opinion).page(params[:page]).per(25)
    if params[:sort] == "book title"
      @ratings = @ratings.joins('INNER JOIN opinions ON opinions.id = ratings.opinion_id').joins('INNER JOIN books ON books.id = opinions.book_id').order('books.title')
    elsif params[:sort] == "usefulness"
      @ratings = @ratings.order(usefulness: :desc)
    else
      @ratings = @ratings.order(created_at: :desc)
    end
    @map = ["Useless", "Useful", "Very useful"]
  end

  def create
    if current_user == Opinion.find(params[:opinion_id]).user
      redirect_back fallback_location: root_url, alert: "You are not allowed to rate your own review."
    elsif current_user.ratings.where(opinion_id: params[:opinion_id]).exists?
      redirect_back fallback_location: root_url, alert: "You are only allowed to rate a review once."
    else
      current_user.create_rating(params[:usefulness], params[:opinion_id])
      redirect_back fallback_location: root_url
    end
  end
end
