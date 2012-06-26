class Merchant < ActiveRecord::Base
  
  attr_accessible :address,   :appearances, :city,    :zip,            
                  :name,      :phone,       :website, :latitude,
                  :longitude, :yipit_merchant_id
  has_many :deals


  def providers
    deals.map(&:provider).uniq
  end

  def run_with_ls?
    providers.include?("livingsocial")
  end

  def providers_to_comma
    if providers.count == 1
      providers.first
    else
      providers.collect { |provider| provider }.join(",")
    end
  end

  def total_revenue
    deals.map(&:revenue).compact.sum
  end

end






