class Api::AddressesController < ApiController

  def show
    if current_user.address_id == params[:id] ||
       Site.where(address_id: params[:id]).count > 0 ||
       Property.where(address_id: params[:id]).count > 0
      render json: Address.find(params[:id]) || {}
    else
      render json: {}
    end
  end

end
