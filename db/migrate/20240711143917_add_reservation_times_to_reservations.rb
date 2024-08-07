class AddReservationTimesToReservations < ActiveRecord::Migration[7.2]
  def change
    add_column :reservations, :start_date, :date
    add_column :reservations, :end_date, :date
    add_column :reservations, :start_time, :time
    add_column :reservations, :end_time, :time
  end
end
