class CheckoutsController < ApplicationController

  def create
    # Find the cart associated with the temp user
    @cart = Cart.find_by(temp_user_id: @temp_user.id)
    
    if @cart.nil?
      flash[:error] = "Cart not found"
      redirect_to products_index_path and return
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: @cart.cart_items.map do |item|
        {
          price_data: {
            currency: 'usd',
            product: item.product_id,
            unit_amount: (item.price * 100).to_i, # Ensure price is in cents
          },
          quantity: item.quantity,
        }
      end,
      mode: 'payment',
      success_url: success_url,
      cancel_url: cancel_url,
    )

    redirect_to @session.url, allow_other_host: true
    
    # Create a reservation record
    @reservation = Reservation.new(reservation_params)
    @reservation.paid = true # Set paid to true as the payment is being processed

    if @reservation.save
      # Proceed with Stripe checkout
      # Stripe payment logic here

      redirect_to success_path, notice: "Reservation created and payment processed successfully."
    else
      render :new, alert: "Error creating reservation. Please try again."
    end
  end

  def new
    
    @cart = Cart.find_by(temp_user_id: @temp_user.id)
    
    if @cart.nil?
    flash[:alert] = "Your cart is currently empty. Please add items to your cart."
    redirect_to products_index_path and return
    end

    @cart_items = CartItem.where(cart_id: @cart.id)

    @products = Stripe::Product.list(limit: 12).data

    if session[:temp_user_id].present?
    @temp_user = TempUser.find_by(id: session[:temp_user_id])

    if @temp_user
      # Check if there are any reservations associated with the current temp_user_id
      @reservation_check = Reservation.where(temp_user_id: @temp_user.id).exists?

      if @reservation_check
        @move_to_waiver = 1
      else
        @move_to_waiver = 2
      end
    end
  end
  end

  def pay
    
    @cart = Cart.find_by(temp_user_id: @temp_user.id)
    
    if @cart.nil?
    flash[:alert] = "Your cart is currently empty. Please add items to your cart."
    redirect_to products_index_path and return
    end

    @cart_items = CartItem.where(cart_id: @cart.id)
    @products = Stripe::Product.list(limit: 12).data

  
  end

  def checkout
    @cart = Cart.find_by(temp_user_id: @temp_user.id)
    
    if @cart.nil?
      flash[:error] = "Cart not found"
      redirect_to products_path and return
    end
    
    # Process payment and order here
    
    session[:temp_user_id] = nil
    redirect_to products_path, notice: 'Thank you for your purchase!'
  end

  def edit_items
    @cart = Cart.find_by(temp_user_id: @temp_user.id)
    @cart_items = CartItem.where(cart_id: @cart.id)
  end

  def update_items
    @cart = Cart.find_by(temp_user_id: @temp_user.id)
  @cart_item = CartItem.find(params[:id])

  if @cart_item.update(item_params)
    respond_to do |format|
      format.html { redirect_to checkouts_new_path, notice: 'Item updated successfully' }
      format.js # Respond with JavaScript
    end
  else
    render :edit_items
  end
end

  def delete_item
  @cart_item = CartItem.find(params[:id])
  @cart_item.destroy

  respond_to do |format|
    format.html { redirect_to checkouts_new_path, notice: 'Item deleted successfully' }
    format.js # Respond with JavaScript
  end
end

  private

  def set_temp_user
    @temp_user = TempUser.find(session[:temp_user_id])
  end

  def reservation_params
    params.permit(:first, :last, :email, :birth, :start_date, :end_date, :start_time, :end_time, :waiver)
  end

  def item_params
    params.require(:cart_item).permit(:quantity, :cart_id)
  end
end
