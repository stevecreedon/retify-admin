class Api::Properties::DirectionsController < ApiController
  before_filter :load_property
  before_filter :check_if_property_belongs_to_user

  def new
    directions = Direction::Titles.map do | title |
      direction = @property.directions.find { | p | p.title == title }

      direction || Direction.new(title: title)
    end  

    render json: directions
  end

  def create
    @direction = Direction.new params[:direction].merge(property_id: @property.id)

    if @direction.save
      current_user.feeds.where( feed_type: :create_property_directions ).destroy_all

      render json: @direction, status: 200
    else
      render json: @direction, status: 400
    end
  end

  def update
    direction = @property.directions.where( id: params[:id] ).first

    if direction.update_attributes(params[:direction])
      current_user.feeds.where( feed_type: :create_property_directions ).destroy_all

      render json: direction, status: 200
    else
      render json: direction, status: 400
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
