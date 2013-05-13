class Api::UsersController < ApiController
  def update
    if current_user.update_attributes(params[:user].except(:address))
      current_user.feeds.create!( feed_type: :create_site )
      current_user.feeds.create!( feed_type: :create_property )

      render json: current_user, status: 200
    else
      render json: current_user, status: 400
    end
  end
end
