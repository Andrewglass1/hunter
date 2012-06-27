class UserMarketsController < ApplicationController
  def create
    @user_market = UserMarket.new(params[:user_market])
    if @user_market.save
      redirect_to root_url, :notice => "Added This Market"
    else
      render :new
    end
  end

  def destroy
    @user_market = UserMarket.find(params[:id])
    @user_market.destroy
    redirect_to user_path(current_user)
  end
  
  def new
    @user_market = UserMarket.new
  end
end
