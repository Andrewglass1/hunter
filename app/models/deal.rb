class Deal < ActiveRecord::Base
  
  attr_accessible :merchant_id,:market_id,  :category,    :date_added,
                  :discount,   :full_title, :price,       :provider,
                  :revenue,  :revenue_index,:short_title, :date_ended, 
                  :sold,     :sold_out,     :value,      :yipit_deal_id,
                  :deal_url, :latitude, :longitude
  
  after_create :standardize_provider
  acts_as_gmappable :process_geocoding => false

  belongs_to :merchant
  belongs_to :market

  def merchant_deal_count
    merchant.deals.count
  end

  def standardize_provider
    if ["Living Social", "Livingsocial", "livingsocial", "Living Social Adventures"].include?(provider)
      self.update_attribute(:provider, "livingsocial")
    end
  end
end
