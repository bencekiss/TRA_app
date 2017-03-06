class AccountSessionsController < ApplicationController


  def new

    if current_user
      redirect_to account_path(current_user.id)
    else
      # if request.original_url == root_url
      #   hide = true
      # else
      #   hide = false
      # end
      @hide = true
      @account = Account.new
  end
  end

  def create
    if @account = login(params[:email], params[:password])
      redirect_back_or_to(account_path(@account.id))
    else
      flash.now[:alert] = 'Unsuccessful login'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(root_path)
  end
end
