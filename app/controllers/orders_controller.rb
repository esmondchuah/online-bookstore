class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:manifests, :books).page(params[:page]).per(25)
    if params[:sort] == "status"
      @orders = @orders.order(status: :desc)
    else
      @orders = @orders.order(created_at: :desc)
    end
    @map = ["Shipping soon", "Shipped", "In transit", "Out for delivery", "Delivered"]
  end

  def create
    order = current_user.create_order
    order.populate_manifests(current_user.carts)
    current_user.carts.destroy_all
    redirect_to root_path, notice: "Your order was successfully created."
  end
end
