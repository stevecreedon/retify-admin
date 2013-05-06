class Api::PropertiesController < ApiController
  def index
    render json: current_user.properties, include_associations: false
  end

  def show
    render json: current_user.properties.where( id: params[:id] ).first
  end

  def new
    render json: Property.new(
      address: current_user.address.dup,
    )
  end

  def create
    property               = Property.new params[:property].except(:address, :user)
    property.user          = current_user
    property.build_address   params[:property][:address]

    if property.save
      current_user.feeds.where( feed_type: :create_property ).destroy_all

      current_user.feeds.create!( feed_type: :create_property_calendar,          parent_id: property.id )
      current_user.feeds.create!( feed_type: :create_property_photos,            parent_id: property.id )
      current_user.feeds.create!( feed_type: :create_property_directions,        parent_id: property.id )
      current_user.feeds.create!( feed_type: :create_property_terms_page,        parent_id: property.id )
      current_user.feeds.create!( feed_type: :create_property_availability_page, parent_id: property.id )

      render json: property, status: 200
    else
      render json: property, status: 400
    end
  end

  def update
    property = current_user.properties.where( id: params[:id] ).first
    property.address.attributes = params[:address]

    status = property.update_attributes(params[:property].except(:address)) ? 200 : 400
    render json: property, status: status
  end
end
