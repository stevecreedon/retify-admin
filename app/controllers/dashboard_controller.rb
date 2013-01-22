class DashboardController < ApplicationController
  def index
    if request.xhr?
      render layout: false
    else
      render
    end
  end

end
