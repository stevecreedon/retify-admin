class DashboardController < ApplicationController

  def index
     respond_to do |format|
       format.html {render :partial => 'dashboard/index'}
     end
  end

end
