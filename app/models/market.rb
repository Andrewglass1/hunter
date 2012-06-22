class Market < ActiveRecord::Base
  include ApplicationHelper
  attr_accessible :name
  has_many :deals
  has_many :merchants, :through => :deals

  def total_month_rev(month, year)
  end

  #known bug, will not work on nil
  def max_revenue
    deals.map(&:revenue).max
  end

  def min_revenue
    deals.map(&:revenue).min
  end

  def months_for_selector
    oldest_date = deals.map(&:date_added).min 
    months_since(oldest_date)
  end
end

