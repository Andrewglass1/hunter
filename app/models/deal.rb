class Deal < ActiveRecord::Base
  
  attr_accessible :merchant_id, :market_id,  :category, :date_added,
                  :discount,    :full_title, :price,    :provider,
                  :revenue,     :date_ended, :value,    :yipit_deal_id,
                  :sold,        :sold_out,   :deal_url, :revenue_index,     
                  :short_title
  
  after_create :standardize_provider

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
