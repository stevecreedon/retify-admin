class Api::Properties::DirectionsController < ApiController
  before_filter :load_property
  before_filter :check_if_property_belongs_to_user

  def new
    render json: Direction.new
  end

  def create
    @direction = Direction.new params[:direction].merge(property_id: @property.id)

    status = @direction.save ? 200 : 400
    render json: @direction, status: status
  end

private 

  def load_property
    @property = Property.find(params[:property_id])
  end

  def check_if_property_belongs_to_user
    render json: { error: 'access denied' }, status: 401 unless @property.user.id == current_user.id
  end
end
