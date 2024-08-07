class CreateInventory < ActiveRecord::Migration[7.2]
  def change
    create_table :inventories do |t|
      t.string :equipment
      t.integer :quantity

      t.timestamps
    end
  end
end
