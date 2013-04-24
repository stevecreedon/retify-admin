class Api::Properties::PhotosController < ApiController
  before_filter :load_property
  before_filter :check_if_property_belongs_to_user

  def index
    render json: @property.photos
  end

  def create
    @photo = PropertyPhoto.new
    @photo.image = params[:files].shift
    @photo.property = @property

    if @photo.save
      current_user.feeds.where( feed_type: :create_property_photos ).destroy_all

      respond_to do |format|
        format.html {                                         #(html response is for browsers using iframe sollution)
          render json: [@photo.to_jq_upload],
          content_type: 'text/html',
          layout: false
        }
        format.json {
          render json: [@photo]
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
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
