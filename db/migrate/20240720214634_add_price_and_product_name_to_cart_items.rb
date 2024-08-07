class AddPriceAndProductNameToCartItems < ActiveRecord::Migration[7.2]
  def change
    add_column :cart_items, :price, :integer
    add_column :cart_items, :product_name, :string
  end
end
