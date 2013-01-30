class SitesController < ApplicationController
  def index
    if site = current_user.sites.first
      redirect_to site_path(site) 
    else
      redirect_to new_site_path
    end
  end

  def show
    @site = current_user.sites.where(id: params[:id]).first
    unless @site
      redirect_to action: :new
    else
      @site = @site.decorate
    end
  end

  def new
    redirect_to action: :index if current_user.sites.count > 0

    @site = Site.new(email: current_user.identities.first.email).decorate
  end

  def create
    redirect_to action: :index if current_user.sites.count > 0

    @site = Site.new params[:site]
    @site.style = 'style_01'
    @site.user  = current_user

    if @site.save
      redirect_to(@site, notice: 'Site was successfully created.')
    else
      @site = @site.decorate
      render :action => "new"
    end
  end

  def edit
    @site = current_user.sites.where(id: params[:id]).first.decorate
  end

  def update
    @site = current_user.sites.where(id: params[:id]).first
 
    if @site.update_attributes(params[:site])
      redirect_to(@site, notice: 'Site was successfully updated.')
    else
      @site = @site.decorate
      render :action => "edit"
    end
  end
end
