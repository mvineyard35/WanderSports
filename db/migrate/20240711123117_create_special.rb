class CreateSpecial < ActiveRecord::Migration[7.2]
  def change
    create_table :specials do |t|
      t.string :info

      t.timestamps
    end
  end
end
