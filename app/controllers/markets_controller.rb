class MarketsController < ApplicationController
  extend Map
  include ApplicationHelper

  before_filter do
    authenticate_user! rescue redirect_to root
  end

  def show
    @market    = Market.find(params[:id])
    @json      = @market.merchants.to_gmaps4rails do |merchant, marker|
      marker.infowindow render_to_string(:partial => "/merchants/pop", :locals => { :merchant => merchant})
      marker.title   "#{merchant.name}"
      marker.picture({
                    :picture => "https://s3.amazonaws.com/huntericons/#{merchant.category_logo+merchant.provider_logo}.png",
                    :width  => 32,
                    :height => 32})
      marker.json({ :revenues => merchant.revenues,
                    :run_with_ls => merchant.run_with_ls?,
                    :run_with_gpn => merchant.run_with_gpn?,
                    :third_party => merchant.third_party_only?,
                    :zip => merchant.zip,
                    :days_since => merchant.days_since_all_runs,
                    :csa =>merchant.in_csa?,
                    :outside_csa => merchant.outside_csa?,
                    :categories => merchant.categories})
    end

    @gmap_options = {"map_options" => Map.map_options,
                     "markers" => {"data" => @json, "options" => Map.marker_options}}
  end

  def index
    @markets = Market.all
  end

  def stats
    @market = Market.find(params[:id])
  end

end
