module Importer
require 'csv'
extend ApplicationHelper

  def self.import
    csv_text = File.read('/Users/andrewglass/Desktop/palm_beach_15.csv')
    csv = CSV.parse(csv_text, {:headers => true, :header_converters => :symbol})
    csv.each do |row|

      row = row.to_hash.with_indifferent_access
      market   = Market.find_or_create_by_name(row['division'])
      merchant = Merchant.find_or_create_by_yipit_merchant_id(
              :address => row['address'],
              :yipit_merchant_id => row['merchant_id'],
              :name => row['merchant_name'],
              :city => row['city'],
              :zip => row['zip_code'],
              :latitude => row['latitude'],
              :longitude => row['longitude'],
              :website => row['merchant_website'],
              :appearances =>row ['appearances'])

      Deal.find_or_create_by_yipit_deal_id(
              :yipit_deal_id => row['id'],
              :market_id => market.id,
              :merchant_id => merchant.id,
              :category => row['category'],
              :date_added => row['date_added'],
              :date_ended => row['date_ended'],
              :deal_url => row['deal_url'],
              :discount => row['discount'],
              :full_title => row['full_title'],
              :price => row['price'],
              :provider => standardize_provider(row['site']),
              :revenue => revenue_or_zero(row['revenue']),
              :revenue_index => row['rev_index'],
              :short_title => row['short_title'],
              :sold => row['sold'],
              :sold_out =>row ['sold_out'],
              :value => row['value'],
              :latitude => merchant.latitude,
              :longitude => merchant.longitude)
    end
  end

end