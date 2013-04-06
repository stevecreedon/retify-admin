class HomeController < ApplicationController
  skip_before_filter :authenticate!
  layout 'home'

  def index
    if current_user
      redirect_to dashboard_index_path
    else
      @identity = PasswordIdentity.new
    end
  end
end
