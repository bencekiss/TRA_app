class ConfirmationsController < ApplicationController
  def new
    @account = Account.find(session[:account_id])
  end

  def create
    @account = Account.find(params[:account_id])
    if @account.verification == params[:verification]
      @account.update(verification: "verified")
      session[:authenticated] = true
      flash[:notice] = "Welcome #{@account.name}!"
      redirect_to new_account_schedule_path
    else
      flash.now[:error] = "Verification code is incorrect"
      render :new
    end
  end



end
