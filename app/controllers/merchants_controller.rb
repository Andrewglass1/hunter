class MerchantsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def show
    @merchant = Merchant.find(params[:id])
    @deals = @merchant.deals.order(sort_column + " " + sort_direction)
  end


private

  def sort_column
    Deal.column_names.include?(params[:sort]) ? params[:sort] : "revenue"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
