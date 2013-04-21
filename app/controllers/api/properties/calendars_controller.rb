class Api::Properties::CalendarsController < ApiController
  before_filter :load_property
  before_filter :check_if_property_belongs_to_user

  def new
    render json: Calendar.new
  end

  def create
    @calendar = Calendar.new params[:calendar].merge(property: @property)
    @calendar.enabled = true

    status = @calendar.save ? 200 : 400
    render json: @calendar, status: status
  end

private 

  def load_property
    @property = Property.find(params[:property_id])
  end

  def check_if_property_belongs_to_user
    render json: { error: 'access denied' }, status: 401 unless @property.user.id == current_user.id
  end
end
