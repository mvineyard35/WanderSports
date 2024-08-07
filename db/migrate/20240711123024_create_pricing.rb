class CreatePricing < ActiveRecord::Migration[7.2]
  def change
    create_table :pricings do |t|
      t.string :option1
      t.string :option2
      t.string :option3
      t.string :option4
      t.string :option5
      t.string :option6

      t.timestamps
    end
  end
end
