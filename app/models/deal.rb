class Deal < ActiveRecord::Base
  
  attr_accessible :merchant_id, :market_id,  :category,   :date_added,
                  :full_title,  :provider,   :date_ended, :yipit_deal_id,
                  :deal_url,    :short_title
  
  after_create :standardize_provider

  has_many :offers
  belongs_to :merchant
  belongs_to :market

  def merchant_deal_count
    merchant.deals.count
  end

  def revenue
    offers.map(&:revenue).compact.sum
  end

  def sold
    offers.map(&:sold).compact.sum
  end

  def standardize_provider
    if ["Living Social", "Livingsocial", "livingsocial", "Living Social Adventures", "LivingSocial Adventures","Living Social Family Edition", "LivingSocial Family Edition", "LivingSocial"].include?(provider)
      self.update_attribute(:provider, "livingsocial")
    elsif ["Groupon", "Groupon Live"].include?(provider)
      self.update_attribute(:provider, "Groupon")
    end
  end

end
