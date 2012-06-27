class Deal < ActiveRecord::Base
  
  attr_accessible :merchant_id,:market_id,  :category,    :date_added,
                  :discount,   :full_title, :price,       :provider,
                  :revenue,  :revenue_index,:short_title, :date_ended, 
                  :sold,     :sold_out,     :value,      :yipit_deal_id,
                  :deal_url, :latitude, :longitude
  
  after_create :standardize_provider
  after_create :remove_bad_categories

  belongs_to :merchant
  belongs_to :market

  def merchant_deal_count
    merchant.deals.count
  end

  def standardize_provider
    if ["Living Social", "Livingsocial", "livingsocial", "Living Social Adventures", "Living Social Family Edition"].include?(provider)
      self.update_attribute(:provider, "livingsocial")
    elsif ["Groupon", "Groupon Live"].include?(provider)
      self.update_attribute(:provider, "Groupon")
    end
  end

end
