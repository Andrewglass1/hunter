class Merchant < ActiveRecord::Base
  attr_accessible :address,   :appearances, :city,    :zip,            
                  :name,      :phone,       :website, :latitude,
                  :longitude, :yipit_merchant_id
  has_many :deals


  def providers
    deals.map(&:provider).uniq
  end
end






