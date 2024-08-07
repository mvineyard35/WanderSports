class RemovePricingOptionsFromPricings < ActiveRecord::Migration[7.2]
  def change
    remove_column :pricings, :option1_price, :string
    remove_column :pricings, :option2_price, :string
    remove_column :pricings, :option3_price, :string
    remove_column :pricings, :option4_price, :string
    remove_column :pricings, :option5_price, :string
    remove_column :pricings, :option6_price, :string
  end
end
