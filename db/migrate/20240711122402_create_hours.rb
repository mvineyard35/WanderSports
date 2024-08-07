class CreateHours < ActiveRecord::Migration[7.2]
  def change
    create_table :hours do |t|
      t.string :mon_fri
      t.string :sat
      t.string :sun

      t.timestamps
    end
  end
end
