class HomeController < ApplicationController
  def index
    redirect_to dashboard_index_path
  end
end
