# -*- encoding : utf-8 -*-
module Importer
require 'csv'
extend ApplicationHelper

DEAL_FILE_LOCATION = '/Users/andrewglass/Desktop/raleigh.csv'
CSA_FILE_LOCATION = '/Users/andrewglass/Desktop/raleigh_csa.csv'


  def self.import
    csv_text = File.read(DEAL_FILE_LOCATION)
    csv = CSV.parse(csv_text, {:headers => true, :header_converters => :symbol})
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      market   = Market.find_or_create_by_name(row['division'])
      if Geocoder::Calculations.distance_between([market.latitude, market.longitude],[row['latitude'],row['longitude']]) < 75

        merchant = Merchant.find_or_create_by_name_and_address(
                :address => row['address'],
                :yipit_merchant_id => row['merchant_id'],
                :name => clean_characters(row['merchant_name']),
                :city => row['city'],
                :zip => row['zip_code'],
                :latitude => row['latitude'],
                :longitude => row['longitude'],
                :website => row['merchant_website'],
                :phone => row['phone'])

        Deal.find_or_create_by_yipit_deal_id(
                :yipit_deal_id => row['id'],
                :market_id => market.id,
                :merchant_id => merchant.id,
                :category => category_or_nil(row['category']),
                :date_added => Date.strptime(row['date_added'], "%m/%d/%Y"),
                :date_ended => Date.strptime(row['date_ended'], "%m/%d/%Y"),
                :deal_url => row['deal_url'],
                :discount => row['discount'],
                :full_title => clean_characters(row['full_title']),
                :price => row['price'],
                :provider => row['site'],
                :revenue => row['revenue'],
                :revenue_index => row['rev_index'],
                :short_title => clean_characters(row['short_title']),
                :sold => row['sold'],
                :sold_out =>row ['sold_out'],
                :value => row['value'])
      end
    end
  end

  def self.import_csa_zips
    csv_text = File.read(CSA_FILE_LOCATION)
    csv = CSV.parse(csv_text, {:headers => true, :header_converters => :symbol})
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      if row['csa'] == "Y"
        market   = Market.find_or_create_by_name(row['name'])
        CsaZip.create(csa_zipcode: row['zip'], market_id: market.id)
      end
    end
  end

end