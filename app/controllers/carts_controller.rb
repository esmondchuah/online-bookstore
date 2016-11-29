class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = current_user.carts
  end

  def create
    current_user.create_cart(cart_params)
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
end
