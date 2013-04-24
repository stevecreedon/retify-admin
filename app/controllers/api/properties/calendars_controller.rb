class Api::Properties::CalendarsController < ApiController
  before_filter :load_property
  before_filter :check_if_property_belongs_to_user

  def new
    render json: Calendar.new
  end

  def create
    @calendar = Calendar.new params[:calendar].merge(property: @property)
    @calendar.enabled = true

    if @calendar.save
      current_user.feeds.where( feed_type: :create_property_calendar ).destroy_all

      render json: @calendar, status: 200
    else
      render json: @calendar, status: 400
    end
  end

private 

  def load_property
    @property = Property.find(params[:property_id])
  end

  def check_if_property_belongs_to_user
    render json: { error: 'access denied' }, status: 401 unless @property.user.id == current_user.id
  end
end
