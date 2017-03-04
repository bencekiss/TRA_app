class AccountSessionsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    if @account = login(params[:email], params[:password])
      redirect_back_or_to(account_path(@account.id), notice: 'Logged in')
    else
      flash.now[:alert] = 'Unsuccessful login'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Logged out')
  end
end
