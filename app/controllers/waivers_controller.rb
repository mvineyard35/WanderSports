class WaiversController < ApplicationController
  def new
    @waiver = Waiver.new

    # Find the reservation for the current temp user
    @reservation = Reservation.find_by(temp_user_id: @temp_user.id)

    if @reservation
      # Prepopulate waiver details from the reservation
      
      @waiver.birth_date = @reservation.birth
      @waiver.email = @reservation.email
    else
      flash[:alert] = "Reservation not found for current user."
      redirect_to some_other_path 
    end
  end

  def create
    @temp_user = TempUser.find(session[:temp_user_id])
    @reservation = Reservation.find_by(temp_user_id: @temp_user.id)
    
    @waiver = Waiver.new(waiver_params)
    
    @waiver.birth_date = @reservation.birth
    @waiver.email = @reservation.email
    @waiver.temp_user_id = @temp_user.id

    if @waiver.save
      reservation = Reservation.find_by(temp_user_id: session[:temp_user_id])

      if reservation
        reservation.update(waiver: true)
      end
      redirect_to checkouts_pay_path, notice: "Waiver was successfully submitted."
    else
      render :new, alert: "There was an error submitting the waiver."
    end
  end

  def view
    # Fetch the email from the parameters
    userID = params[:temp_user_id]
    
    # Retrieve all waiver records associated with the given email
    @waivers = Waiver.where(temp_user_id: userID)
    @reservations = Reservation.where(temp_user_id: userID)
  end

  private

  def waiver_params
    params.require(:waiver).permit(:first_name, :last_name, :birth_date, :email, :guardian_name, :signature, :authorized, :temp_user_id)
  end
  def set_temp_user
    @temp_user = TempUser.find(session[:temp_user_id])
  end
end
