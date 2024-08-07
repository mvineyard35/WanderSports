class CreateWaivers < ActiveRecord::Migration[7.2]
  def change
    create_table :waivers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :birth_date, null: false
      t.string :email, null: false
      t.text :signature, null: false
      t.boolean :authorized, default: false, null: false

      t.timestamps
    end

    add_index :waivers, :email, unique: true
  end
end