class CreateReservation < ActiveRecord::Migration[7.2]
  def change
    create_table :reservations do |t|
      t.string :first
      t.string :last
      t.string :email
      t.date :birth
      t.boolean :paid
      t.boolean :waiver

      t.timestamps
    end
  end
end
