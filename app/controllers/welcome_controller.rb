class WelcomeController < ApplicationController
  def show
    redirect_to market_path(Market.first) if current_user
  end
end
