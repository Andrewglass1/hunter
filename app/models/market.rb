class Market < ActiveRecord::Base
  attr_accessible :name
  has_many :deals
  has_many :merchants, :through => :deals
end

