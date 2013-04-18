class Api::PropertiesController < ApiController

  def new
    render json: Property.new(
      address: current_user.address.dup,
    )
  end

  def create
    @property               = Property.new params[:property].except(:address, :user)
    @property.user          = current_user
    @property.build_address   params[:property][:address]

    status = @property.save ? 200 : 400
    render json: @property, status: status
  end
end
