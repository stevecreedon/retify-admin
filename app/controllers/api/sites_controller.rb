class Api::SitesController < ApiController

  def index
    render json: current_user.sites
  end

  def show
    render json: current_user.sites.where(id: params[:id]).first || {}
  end

  def new
    render json: Site.new(
      address: current_user.address.dup,
      phone: current_user.phone,
      email: current_user.email
    )
  end

  def create
    #TODO if site already exists
    # redirect_to action: :index if current_user.sites.count > 0

    @site               = Site.new params[:site].except(:address, :user)
    @site.style         = 'style_01'
    @site.user          = current_user
    @site.build_address   params[:site][:address]
 
    status = @site.save ? 200 : 400
    render json: @site, status: status
  end

end
