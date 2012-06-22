class MarketsController < ApplicationController
  extend Map
  include ApplicationHelper
  def show
    @market    = Market.find(params[:id])
    @merchants = @market.merchants
    @deals     = @market.deals
    @json      = @deals.to_gmaps4rails do |deal, marker|
      marker.infowindow render_to_string(:partial => "/deals/pop", :locals => { :deal => deal})
      marker.picture({:color => "http://www.askeachother.com/images/uploads/large/2011-04-03-2713018_Amazon-logo-small.jpg",
                      :width   => 32,
                      :height  => 32})
      marker.title   "#{deal.merchant.name}"
      marker.sidebar "i'm the sidebar"
      marker.json({ :revenue => deal.revenue, :ls_merchant => deal.merchant.run_with_ls?,
                    :provider => deal.provider, :zip => deal.merchant.zip,
                    :months_since => months_since(deal.date_added) })
    end

    @gmap_options = {"map_options" => Map.map_options,
                     "markers" => {"data" => @json,
                                   "options" => Map.marker_options}}
  end

  def index
    @markets = Market.all
  end
end
