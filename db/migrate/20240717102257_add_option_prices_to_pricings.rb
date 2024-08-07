class AddOptionPricesToPricings < ActiveRecord::Migration[6.1]
  def change
    add_column :pricings, :option1_price, :string
    add_column :pricings, :option2_price, :string
    add_column :pricings, :option3_price, :string
    add_column :pricings, :option4_price, :string
    add_column :pricings, :option5_price, :string
    add_column :pricings, :option6_price, :string
  end
end
