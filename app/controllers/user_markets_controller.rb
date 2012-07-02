class UserMarketsController < ApplicationController

  def create
    @user_market = UserMarket.new(params[:user_market])
    if @user_market.save
      flash[:notice] = "This market has been added to your markets."
      redirect_to markets_path
    else
      render :new
    end
  end

  def destroy
    @user_market = UserMarket.find(params[:id])
    @user_market.destroy
    flash[:notice] = "This market has been removed from your markets."
    redirect_to markets_path
  end
  
  def new
    @user_market = UserMarket.new
  end
end
