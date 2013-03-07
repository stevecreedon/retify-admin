class DashboardController < ApplicationController

  def index
    if current_user.sites.count == 0 ||
       current_user.properties.count == 0
      redirect_to tutorial_index_path
    end
  end

end
