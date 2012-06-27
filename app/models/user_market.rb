class UserMarket < ActiveRecord::Base
  attr_accessible :market_id, :user_id
  belongs_to :user
  belongs_to :market
  validates_uniqueness_of :user_id, :scope => :market_id
end
