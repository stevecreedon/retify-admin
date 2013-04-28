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
 
    if @site.save
      current_user.feeds.where( feed_type: :create_site ).destroy_all

      render json: @site, status: 200
    else
      render json: @site, status: 400
    end
  end

  def update
    site = current_user.sites.where( id: params[:id] ).first
    site.address.attributes = params[:address]

    status = site.update_attributes(params[:site].except(:address, :user)) ? 200 : 400
    render json: site, status: status
  end

end
