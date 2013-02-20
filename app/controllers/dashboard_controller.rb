class DashboardController < ApplicationController
  
  def index
    @user = current_user.decorate
    notifications << "please verify your email address" if @user.nag? 
  end

end
