class PropertiesController < ApplicationController

  def index
    @properties = current_user.properties

     respond_to do |format|
       format.html {render :partial => 'properties/index'}
     end
  end

end
