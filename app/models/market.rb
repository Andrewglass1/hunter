class Market < ActiveRecord::Base
  include ApplicationHelper
  
  attr_accessible :name, :latitude, :longitude
  has_many :deals
  has_many :merchants, :through => :deals, :uniq => true
  has_many :user_markets
  has_many :users, :through => :user_markets
  has_many :csa_zips

  after_create :calculate_lat_long

  def max_revenue
    deals.map(&:revenue).compact.max
  end

  def min_revenue
    deals.map(&:revenue).compact.min
  end

  def days_for_selector
    oldest_date = deals.map(&:date_added).compact.min 
    days_since(oldest_date)
  end

  def calculate_lat_long
    lat_long = Geocoder.coordinates(name)
    self.update_attributes(:latitude => lat_long[0], :longitude => lat_long[1])
  end

  def all_csa_zipcodes
    csa_zips.collect {|csazip| csazip.csa_zipcode}
  end

  def categories_index
    cats = deals.map(&:category).compact
    index = {}
    cats.each { |i| index.include?(i) ? index[i] += 1 : index[i] = 1}
    index.sort_by { |key, value| value }.reverse
  end

  def categories_index_with_total_revenue
    index = {}
    categories = deals.map(&:category).uniq.compact
    categories.each do |category|
      deals = Deal.where("category = '#{category}' AND market_id = #{id}")
      revenue = deals.map(&:revenue).compact.sum
      index[category] = revenue
    end
    index.sort_by { |key, value| value }.reverse
  end

  def graphael_data
    revenues = categories_index_with_total_revenue.collect {|category,revenue| revenue}
    legend = categories_index_with_total_revenue.collect {|category,revenue| "%%.%% - #{category.html_safe}" }
    [revenues, legend]
  end

  def self.categories_index_with_total_revenue
    index = {}
    categories = Deal.all.map(&:category).uniq.compact
    categories.each do |category|
      deals = Deal.where("category = '#{category}'")
      revenue = deals.map(&:revenue).compact.sum
      index[category] = revenue
    end
    index.sort_by { |key, value| value }.reverse
  end

  def self.graphael_data
    revenues = Market.categories_index_with_total_revenue.collect {|category,revenue| revenue}
    legend = Market.categories_index_with_total_revenue.collect {|category,revenue| "%%.%% - #{category.html_safe}" }
    [revenues, legend]
  end

  def zips_index
    zips = merchants.map(&:zip).compact
    index = {}
    zips.each { |i| index.include?(i) ? index[i] += 1 : index[i] = 1}
    index.sort_by { |key, value| value }.reverse
  end
end

