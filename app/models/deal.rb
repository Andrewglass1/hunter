class Deal < ActiveRecord::Base
  attr_accessible :merchant_id,:market_id,  :category,    :date_added,
                  :discount,   :full_title, :price,       :provider,
                  :revenue,  :revenue_index,:short_title, :date_ended, 
                  :sold,     :sold_out,     :value,      :yipit_deal_id,
                  :deal_url, :latitude, :longitude
  
  acts_as_gmappable :process_geocoding => false

  belongs_to :merchant
  belongs_to :market

end
