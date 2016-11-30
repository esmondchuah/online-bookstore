class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @orders_count = @user.orders.where.not(status: 4).count
    @opinions_count = @user.opinions.count
  end
end
