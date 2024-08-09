class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @temp_user = TempUser.find(session[:temp_user_id])
    @reservation.temp_user_id = @temp_user.id

  end

  def create
    

    @reservation = Reservation.new(reservation_params)
    @temp_user = TempUser.find(session[:temp_user_id])
    @reservation.temp_user_id = @temp_user.id

    if @reservation.save
      ReservationMailer.reservation_confirmation(@reservation).deliver_later
      ReservationMailer.reservation_notification(@reservation).deliver_later
      redirect_to waivers_new_path, notice: "Reservation was successfully created."
    else
      flash.now[:alert] = 'Date cannot be in the past'
      render :reserve
    end
  end

  def reserve
  # Ensure session[:temp_user_id] is present
  if session[:temp_user_id].present?
    @temp_user = TempUser.find_by(id: session[:temp_user_id])

    if @temp_user
      # Check if there are any reservations associated with the current temp_user_id
      @reservation_check = Reservation.where(temp_user_id: @temp_user.id).exists?

      if @reservation_check
        @move_to_waiver = 1
      else
        @move_to_waiver = 2
      end
    end
  end
end

def view
  @reservations = Reservation.where('start_date >= ?', Date.today)
end
def past
  @reservations = Reservation.where('start_date < ?', Date.today)
end
private

  def reservation_params
  params.permit(
    :first, :last, :email, :phone_number, :birth, :start_date, :end_date,
    :start_time_hour, :start_time_minute, :start_time_period,
    :end_time_hour, :end_time_minute, :end_time_period, :temp_user_id
  )
end
  
 def set_temp_user
  @temp_user = TempUser.find(session[:temp_user_id])
 end
end


