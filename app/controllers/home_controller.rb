class HomeController < ApplicationController
  before_action :set_model_instance, only: [:edit, :update]
  def edit
  end
  def gallery
  @images = Image.order(created_at: :desc)
end

   def update
    if @model_instance.update(model_params)
      redirect_to home_view_path, notice: "#{@model_instance.model_name.human} was successfully updated."
    else
      render :edit
    end
  end
  def index
    @specials = Special.all
    @hours = Hour.all
  end
  def about
  end
  def policies
  end
  def contact
  end
  def edit_special
    @special = Special.find(params[:id])
  end
  def edit_image
    @image = Image.find(params[:id])
  end

  def update_special
    @special = Special.find(params[:id])
    if @special.update(special_params)
      redirect_to home_view_path, notice: 'Special was successfully updated.'
    else
      render :edit_special
    end
  end
  def update_image
    @image = Image.find(params[:id])
    if @image.update(image_params)
      redirect_to home_view_path, notice: 'Image was successfully updated.'
    else
      render :edit_image
    end
  end
  def edit_inventory
    @inventory = Inventory.find(params[:id])
  end

  def update_inventory
    @inventory = Inventory.find(params[:id])
    if @inventory.update(inventory_params)
      redirect_to home_view_path, notice: 'Inventory was successfully updated.'
    else
      render :edit_inventory
    end
  end
  def edit_pricing
    @pricing = Pricing.find(params[:id])
  end

  def update_pricing
    @pricing = Pricing.find(params[:id])
    if @pricing.update(pricing_params)
      redirect_to home_view_path, notice: 'Pricing was successfully updated.'
    else
      render :edit_pricing
    end
  end
  def edit_additional
    @additional = Additional.find(params[:id])
  end

  def update_special
    @additional = Additional.find(params[:id])
    if @additional.update(additional_params)
      redirect_to home_view_path, notice: 'Additional was successfully updated.'
    else
      render :edit_additional
    end
  end
  def edit_hour
    @hours = Hour.find(params[:id])
  end

  def update_hour
    @hours = Hour.find(params[:id])
    if @hours.update(hours_params)
      redirect_to home_view_path, notice: 'Hours was successfully updated.'
    else
      render :edit_hour
    end
  end
  def view
    @specials = Special.all
    @inventories = Inventory.all
    @pricings = Pricing.all
    @additionals = Additional.all
    @hours = Hour.all
    @images = Image.all
  end

  def delete_special
    special = Special.find(params[:id])
    special.destroy
    redirect_to home_view_path, notice: 'Special was successfully deleted.'
  end

  def delete_image
    image = Image.find(params[:id])
    image.destroy
    redirect_to home_view_path, notice: 'Image was successfully deleted.'
  end

  def delete_inventory
    inventory = Inventory.find(params[:id])
    inventory.destroy
    redirect_to home_view_path, notice: 'Inventory item was successfully deleted.'
  end

  def delete_pricing
    pricing = Pricing.find(params[:id])
    pricing.destroy
    redirect_to home_view_path, notice: 'Pricing options were successfully deleted.'
  end

  def delete_additional
    additional = Additional.find(params[:id])
    additional.destroy
    redirect_to home_view_path, notice: 'Additional options were successfully deleted.'
  end

  def delete_hour
    hour = Hour.find(params[:id])
    hour.destroy
    redirect_to home_view_path, notice: 'Hours were successfully deleted.'
  end
  def admin
    @special = Special.new
    @inventory = Inventory.new
    @pricing = Pricing.new
    @additional = Additional.new
    @hours = Hour.new
    @images = Image.new
  end

  def create_special
    @special = Special.new(special_params)

    if @special.save
      redirect_to home_admin_path, notice: 'Specials were successfully saved.'
    else
      render :admin
    end
  end

  def create_image
    @image = Image.new(image_params)

    if @image.save
      redirect_to home_admin_path, notice: "Image was successfully saved."
    else
      render :admin
    end
  end

  def create_inventory
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      redirect_to home_admin_path, notice: 'Inventory items were successfully saved.'
    else
      render :admin
    end
  end

  def create_pricing
    @pricing = Pricing.new(pricing_params)

    if @pricing.save
      redirect_to home_admin_path, notice: 'Prices were successfully saved.'
    else
      render :admin
    end
  end

  def create_additional
    @additional = Additional.new(additional_params)

    if @additional.save
      redirect_to home_admin_path, notice: 'Additional items were successfully saved.'
    else
      render :admin
    end
  end

  def create_hours
    @hours = Hour.new(hours_params)

    if @hours.save
      redirect_to home_admin_path, notice: 'Hours were successfully saved.'
    else
      render :admin
    end
  end

  private

  def set_model_instance
    @model_instance = params[:type].constantize.find(params[:id])
    @update_path = url_for(action: :update, id: @model_instance.id, type: params[:type])
  end

  def model_params
    params.require(params[:type].underscore.to_sym).permit!
  end

  def image_params
    params.permit(:image)
  end

  def special_params
    params.permit(:info)
  end

  def inventory_params
    params.permit(:equipment, :quantity)
  end

  def pricing_params
    params.permit(:option1, :option2, :option3, :option4, :option5, :option6)
  end

  def additional_params
    params.permit(:option1, :option2, :option3, :option4, :option5, :option6)
  end

  def hours_params
    params.permit(:mon_fri, :sat, :sun)
  end
end
