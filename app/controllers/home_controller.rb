class HomeController < ApplicationController
  skip_before_filter :authenticate!, :check_account_for_user

  def index
    if current_user
      redirect_to app_path
    else
      @identity = PasswordIdentity.new
    end
  end
end
