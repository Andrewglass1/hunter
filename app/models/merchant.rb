class Merchant < ActiveRecord::Base
  include ApplicationHelper

  attr_accessible :address,   :appearances, :city,    :zip,            
                  :name,      :phone,       :website, :latitude,
                  :longitude, :yipit_merchant_id
  has_many :deals
  acts_as_gmappable :process_geocoding => false


  def providers
    deals.map(&:provider).uniq.compact
  end

  def revenues
    deals.map(&:revenue).uniq.compact
  end

  def days_since_all_runs
    all_run_dates = deals.map(&:date_added).uniq.compact
    all_run_dates.collect{|date| days_since(date)}
  end

  def run_with_ls?
    providers.include?("livingsocial")
  end

  def run_with_gpn?
    providers.include?("Groupon")
  end

  def third_party_only?
    !run_with_ls? && !run_with_gpn?
  end

  def providers_to_comma
    if providers.compact.count == 1
      providers.first
    else
      providers.compact.collect { |provider| provider }.join(", ")
    end
  end

  def most_recent_run_date
    deals_sorted = deals.sort_by &:date_added
    deals_sorted.last.date_added
  end

  def most_recent_provider
    deals_sorted = deals.sort_by &:date_added
    deals_sorted.last.provider
  end

  def total_revenue
    deals.map(&:revenue).compact.sum
  end

end






