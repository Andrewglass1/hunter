class DealsController < ApplicationController
  def show
    @deal = Deal.find(params[:id])
  end

  def index
    @deals = Deal.all
  end
end

