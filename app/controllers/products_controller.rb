class ProductsController < ApplicationController
  before_action :set_temp_user, only: [:add_to_cart]
  def index
    @products = Stripe::Product.list(limit: 12, active: true).data

  end

  def add_to_cart
  # Find or create the cart for the temp user
  @cart = Cart.find_or_create_by(temp_user_id: @temp_user.id)

  # Find the product from Stripe
  stripe_product = Stripe::Product.retrieve(params[:id])

  product_id = stripe_product.id.to_s

  if stripe_product
    # Fetch the price from Stripe. This assumes you're using a Price object related to the Product.
    stripe_price = Stripe::Price.list(product: stripe_product.id).data.first
    price_cents = stripe_price&.unit_amount || 0  # Adjust as needed based on Stripe's response
    product_name = stripe_product.name
    price = (price_cents / 100.0).to_i
    product_description = stripe_product.description

    # Find or create a cart item
    @cart_item = @cart.cart_items.find_by(product_id: stripe_product.id)

    if @cart_item
      # If the cart item already exists, update its quantity
      @cart_item.quantity += params[:quantity].to_i
      @cart_item.save
    else
      # Otherwise, create a new cart item
      @cart.cart_items.create(
        cart_id: @cart.id,
        product_id: product_id,
        product_name: product_name,
        quantity: params[:quantity],
        product_description: product_description,
        price: price
      )
    end

    redirect_to products_index_path(anchor: 'products')
    flash[:notice] = "Item added successfully"
  else
    flash[:error] = "Product not found"
    redirect_to products_index_path
  end
end

  private

  def set_temp_user
    @temp_user = TempUser.find_by(id: session[:temp_user_id])
    unless @temp_user
      @temp_user = TempUser.create!
      session[:temp_user_id] = @temp_user.id
    end
  end
end

