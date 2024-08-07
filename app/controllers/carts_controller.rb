class CartsController < ApplicationController
  before_action :set_cart

  def index
    @cart_items = @cart.cart_items.includes(:product)
  end
  def show
    @cart_items = @cart.cart_items.includes(:product)
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(temp_user: current_temp_user)
  end
end
