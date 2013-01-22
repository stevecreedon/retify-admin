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
    @site = Site.new email: current_user.email
  end

  def create
    @site = Site.new params[:site]
    @site.style = 'style_01'
    @site.user  = current_user

    if @site.save
      redirect_to(@site, notice: 'Site was successfully created.')
    else
      render :action => "new"
    end
  end
end
