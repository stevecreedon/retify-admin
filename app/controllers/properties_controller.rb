class PropertiesController < ApplicationController
  layout false

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

  end

end
