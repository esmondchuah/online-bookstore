class CartsController < ApplicationController
  before_action :authenticate_user!

  # refer to https://redis.io/commands#hash for documentation of functions

  def show
    @cart_books = Hash.new
    $redis.hkeys(current_user.cart).each do |key|
      @cart_books[Book.find(key[/\d+/].to_i)] = $redis.hget(current_user.cart, key).to_i
    end
  end

  def add
    if $redis.hsetnx(current_user.cart, params[:book_id], params[:quantity]) == 0
      $redis.hincrby(current_user.cart, params[:book_id], params[:quantity])
    end
    redirect_to :back
  end

  def remove
    $redis.hdel(current_user.cart, params[:book_id])
    redirect_to :back
  end
end
