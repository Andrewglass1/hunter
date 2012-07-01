class UserMarketsController < ApplicationController

  def create
    @user_market = UserMarket.new(params[:user_market])
    if @user_market.save
      redirect_to root_url, :notice => "This market has been added to your markets."
    else
      render :new
    end
  end

  def destroy
    @user_market = UserMarket.find(params[:id])
    @user_market.destroy
    redirect_to markets_path, :notice => "This market has been removed from your markets."
  end
  
  def new
    @user_market = UserMarket.new
  end
end
