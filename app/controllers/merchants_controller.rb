class MerchantsController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_filter do
    authenticate_user! rescue redirect_to root
  end

  def show
    @merchant = Merchant.find(params[:id])
    @deals = @merchant.deals
  end

end
