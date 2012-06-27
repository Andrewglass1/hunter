class CsaZip < ActiveRecord::Base
  attr_accessible :csa_zipcode, :market_id

  belongs_to :market
end
