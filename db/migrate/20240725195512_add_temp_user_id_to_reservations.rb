class AddTempUserIdToReservations < ActiveRecord::Migration[7.2]
  def change
    add_column :reservations, :temp_user_id, :integer
  end
end
