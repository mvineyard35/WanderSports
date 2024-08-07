class UpdateReservationsTimeColumns < ActiveRecord::Migration[7.2]
  def change
    remove_column :reservations, :start_time, :datetime
    remove_column :reservations, :end_time, :datetime

    add_column :reservations, :start_time_hour, :integer
    add_column :reservations, :start_time_minute, :integer
    add_column :reservations, :start_time_period, :string
    add_column :reservations, :end_time_hour, :integer
    add_column :reservations, :end_time_minute, :integer
    add_column :reservations, :end_time_period, :string
  end
end
