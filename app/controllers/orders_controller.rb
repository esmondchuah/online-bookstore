class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart!

  def create
    order = current_user.create_order
    order.populate_manifests(current_user.get_cart_books)
    $redis.del "cart#{current_user.id}"
    redirect_to root_path
  end

  private

  def check_cart!
    if current_user.get_cart_books.blank?
      redirect_to root_path, alert: "Please add some items to your cart before processing your order!"
    end
  end
end