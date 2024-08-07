class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_temp_user

  private

  def set_temp_user
    if session[:temp_user_id]
      @current_temp_user = TempUser.find_by(id: session[:temp_user_id])
    end
    @current_temp_user ||= TempUser.create
    session[:temp_user_id] = @current_temp_user.id
  end

  def current_temp_user
    @current_temp_user
  end

  helper_method :cart_item_count

  def cart_item_count
  # Retrieve the temp user from the session
  temp_user = TempUser.find_by(id: session[:temp_user_id])

  # Return 0 if no temp user is found
  return 0 unless temp_user

  # Find the cart associated with the temp user
  cart = Cart.find_by(temp_user_id: temp_user.id)

  # Return 0 if no cart exists
  return 0 unless cart

  # Retrieve cart items and sum their quantities
  cart.cart_items.sum(:quantity)
end

  
  
end
