class DealsController < ApplicationController

  before_filter do
    authenticate_user! rescue redirect_to root
  end
  
  def show
    @deal = Deal.find(params[:id])
  end

  def index
    @deals = Deal.all
  end
end

