class Properties::DirectionsController < ApplicationController
  before_filter :load_property
  before_filter :load_directions
  before_filter :check_if_property_belongs_to_user

  helper_method :direction_data

  def index
    unless @property.directions.any?
      redirect_to new_property_direction_path(@property)
    end
  end

  def new
  end

  def create
    Direction::TYPES.each do | title |
      key = title.parameterize.underscore.to_sym
      directions = @property.directions.where(title: title)
      if params[key].empty?
        directions.delete_all
      else
        directions.first_or_initialize.update_attributes! description: params[key]
      end
    end

    redirect_to property_directions_path(@property)
  end

private

  def direction_data
  end 

  def load_directions
    @directions = @property.directions.inject({}) { | res, direction | res[direction.title.parameterize.underscore.to_sym] = direction.description; res }
  end

  def load_property
    @property = Property.find(params[:property_id])
  end

  def check_if_property_belongs_to_user
    if @property.user != current_user
      redirect_to root_path
    end
  end
end
