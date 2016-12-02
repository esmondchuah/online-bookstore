class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:manifests, :books)
    @map = ["Shipping soon", "Shipped", "In transit", "Out for delivery", "Delivered"]
  end

  def create
    order = current_user.create_order
    order.populate_manifests(current_user.carts)
    current_user.carts.destroy_all
    redirect_to root_path
  end
end
