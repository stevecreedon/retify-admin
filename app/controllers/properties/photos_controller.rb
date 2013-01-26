class Properties::PhotosController < ApplicationController
  before_filter :load_property
  before_filter :check_if_property_belongs_to_user

  def show
    @photo = @property.photos.where( id:params[:id] ).first
  end

  def create
    @photo = PropertyPhoto.new
    @photo.image = params[:files].shift
    @photo.property = @property

    if @photo.save
      respond_to do |format|
        format.html {                                         #(html response is for browsers using iframe sollution)
          render :json => [@photo.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@photo.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def destroy
    photo = @property.photos.where( id:params[:id] ).first
    photo.destroy

    render action: :index
  end

private

  def load_property
    @property = Property.find(params[:property_id])
  end

  def check_if_property_belongs_to_user
    if @property.user != current_user
      redirect_to root_path
    end
  end
end
