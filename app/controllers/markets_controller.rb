class MarketsController < ApplicationController
  extend Map
  include ApplicationHelper
  def show
    @market    = Market.find(params[:id])
    @json      = @market.merchants.to_gmaps4rails do |merchant, marker|
      marker.infowindow render_to_string(:partial => "/merchants/pop", :locals => { :merchant => merchant})
      marker.picture({:color => "http://www.askeachother.com/images/uploads/large/2011-04-03-2713018_Amazon-logo-small.jpg",
                      :width   => 32,
                      :height  => 32})
      marker.title   "#{merchant.name}"
      marker.json({ :revenues => merchant.revenues, :run_with_ls => merchant.run_with_ls?,
                    :run_with_gpn => merchant.run_with_gpn?, :third_party => merchant.third_party_only?, :zip => merchant.zip,
                    :days_since => merchant.days_since_all_runs, :csa =>merchant.in_csa})
    end

    @gmap_options = {"map_options" => Map.map_options,
                     "markers" => {"data" => @json,
                                   "options" => Map.marker_options}}
  end

  def index
    @markets = Market.all
  end
end
