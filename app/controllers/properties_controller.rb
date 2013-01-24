class PropertiesController < ApplicationController
  def index
    if property = current_user.properties.first
      redirect_to property_path(property) 
    else
      redirect_to new_property_path
    end
  end

  def show
    @property = current_user.properties.where(id: params[:id]).first
    redirect_to action: :new unless @property
  end

  def new
    redirect_to action: :index if current_user.properties.count > 0

    @property = Property.new address: Address.new
  end

  def create
    redirect_to action: :index if current_user.properties.count > 0

    @property = Property.new params[:property].except(:address)
    @property.build_address params[:property][:address]
    @property.user = current_user

    if @property.save
      redirect_to(@property, notice: 'Property was successfully created.')
    else
      render :action => "new"
    end
  end

  def edit
    @property = current_user.properties.where(id: params[:id]).first
  end

  def update
    @property = current_user.properties.where(id: params[:id]).first
    @property.address.attributes = params[:property][:address]

    if @property.update_attributes(params[:property].except(:address))
      redirect_to(@property, notice: 'Property was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
