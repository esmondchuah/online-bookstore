class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = current_user.carts
    @total_price = total_price
  end

  def create
    current_user.create_cart(cart_params)
    redirect_to :back
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
    redirect_to :back
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_path
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity, :book_id)
  end

  def total_price
    sum = 0
    current_user.carts.each {|cart| sum += cart.book.price * cart.quantity}
    sum
  end
end
