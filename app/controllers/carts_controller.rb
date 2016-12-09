class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = current_user.carts.includes(:book)
    @total_price = total_price
  end

  def create
    @cart = current_user.carts.where(book_id: cart_params[:book_id]).take
    if @cart.blank?
      current_user.create_cart(cart_params)
    else
      @cart.update(quantity: @cart.quantity + cart_params[:quantity].to_i)
    end
    redirect_to book_path(cart_params[:book_id], recommend: true), notice: "Added to your cart successfully."
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
    redirect_back fallback_location: carts_url, notice: "Item(s) in your cart were successfully updated."
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_path, notice: "Item(s) in your cart were successfully deleted."
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
