class SitesController < ApplicationController
  layout false

  def index
    if site = current_user.sites.first
      redirect_to site_path(site) 
    else
      redirect_to new_site_path
    end
  end

  def show
    @site = current_user.sites.where(id: params[:id]).first
    redirect_to action: :new unless @site
  end

  def new
    redirect_to action: :index if current_user.sites.count > 0

    @site = Site.new email: current_user.email
  end

  def create
    redirect_to action: :index if current_user.sites.count > 0

    @site = Site.new params[:site]
    @site.style = 'style_01'
    @site.user  = current_user

    if @site.save
      redirect_to(@site, notice: 'Site was successfully created.')
    else
      render :action => "new"
    end
  end

  def edit
    @site = current_user.sites.where(id: params[:id]).first
  end

  def update
    @site = current_user.sites.where(id: params[:id]).first
 
    if @site.update_attributes(params[:site])
      redirect_to(@site, notice: 'Site was successfully updated.')
    else
      render :action => "edit"
    end
  end
end
