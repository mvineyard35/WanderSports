class AddProductDescriptionToCartItems < ActiveRecord::Migration[7.2]
  def change
    add_column :cart_items, :product_description, :string
  end
end
