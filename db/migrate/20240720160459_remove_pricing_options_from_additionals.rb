class RemovePricingOptionsFromAdditionals < ActiveRecord::Migration[7.2]
  def change
    remove_column :additionals, :option1_price, :string
    remove_column :additionals, :option2_price, :string
    remove_column :additionals, :option3_price, :string
    remove_column :additionals, :option4_price, :string
    remove_column :additionals, :option5_price, :string
    remove_column :additionals, :option6_price, :string
  end
end
