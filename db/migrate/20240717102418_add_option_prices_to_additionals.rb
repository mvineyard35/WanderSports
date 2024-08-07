class AddOptionPricesToAdditionals < ActiveRecord::Migration[7.2]
  def change
    add_column :additionals, :option1_price, :string
    add_column :additionals, :option2_price, :string
    add_column :additionals, :option3_price, :string
    add_column :additionals, :option4_price, :string
    add_column :additionals, :option5_price, :string
    add_column :additionals, :option6_price, :string
  end
end
