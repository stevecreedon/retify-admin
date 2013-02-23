class AccountsController < ApplicationController
  skip_before_filter :check_account_for_user

  layout 'home', only: [:edit, :update]

  def edit
    @user = current_user.decorate
    @user.address = Address.new
  end

  def update
    current_user.build_address params[:user][:address]

    if current_user.update_attributes(params[:user].except(:address))
      redirect_to(dashboard_index_path, notice: 'Account was successfully created.')
    else
      @user = current_user.decorate
      render :action => "edit"
    end
  end
end
