class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.all
    @map = ["Shipping soon", "Shipped", "In transit", "Out for delivery", "Delivered"]
  end

  def create
    order = current_user.create_order
    order.populate_manifests(current_user.get_cart_books)
    $redis.del "cart#{current_user.id}"
    redirect_to root_path
  end
end