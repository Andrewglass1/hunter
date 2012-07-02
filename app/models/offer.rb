class Offer < ActiveRecord::Base
 	attr_accessible :price, :value, :discount, :sold, :revenue, :revenue_index
   	belongs_to :deal
end
