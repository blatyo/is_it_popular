class SitesController < ApplicationController
  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.find_or_initialize_by_url(params[:site][:url])

    if @site.save
      redirect_to site_path(@site)
    else
      redirect_to :back, :flash => {:error => @site.errors[:url]}
    end
  end
end
