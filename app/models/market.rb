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

  def categories
    deals.map(&:category).compact.uniq
  end

  def categories_index
    cats = deals.map(&:category).compact
    index = {}
    cats.each { |i| index.include?(i) ? index[i] += 1 : index[i] = 1}
    index.sort_by { |key, value| value }.reverse
  end

  def zips
    merchants.map(&:zip).uniq
  end

  def zips_index
    zips = merchants.map(&:zip).compact
    index = {}
    zips.each { |i| index.include?(i) ? index[i] += 1 : index[i] = 1}
    index.sort_by { |key, value| value }.reverse
  end
end

