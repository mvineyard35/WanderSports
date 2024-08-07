class AddPhoneNumberToReservations < ActiveRecord::Migration[7.2]
  def change
    add_column :reservations, :phone_number, :string
  end
end
