class Api::FeedsController < ApiController
  def index
    render json: current_user.feeds
  end

  def destroy

  end
end
