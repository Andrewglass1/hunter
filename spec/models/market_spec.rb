require 'spec_helper'
describe Market do

  let!(:market) {Market.create(name:"city")}
  let!(:merchant) { Merchant.create(name: "test", zip: "11753") }
  let!(:deal) { market.deals.create(merchant_id: merchant.id, revenue: 50, date_added: Date.today, category: "testcat1")}
  let!(:deal1) { market.deals.create(merchant_id: merchant.id, revenue: 5, date_added: Date.today-20, category: "testcat2")}
  let!(:csa) { market.csa_zips.create(csa_zipcode: "11753")}


  describe "#max_revenue" do
    it "returns the revenue of the top performing deal in the market" do
        market.max_revenue.should == 50
    end
  end

  describe "#min_revenue" do
    it "returns the revenue of the lowest performing deal in the market" do
        market.min_revenue.should == 5
    end
  end

  describe "#days_for_selector" do
    it "returns the length in days from the oldest deal in the market" do
      market.days_for_selector.class.should == Fixnum
    end
  end

  describe "#categories" do
    it "returns an array of categories for deals run in that market" do
      market.categories.class == Array
    end

    it "returns the categories for all of the deals" do
      market.deals.each do |deal|
        market.categories.include?(deal.category).should == true
      end
    end
  end

  describe "#zips" do
    it "returns an array of zip codes for merchants in that market" do
      market.zips.class == Array
    end
  end

  it "returns the zip codes for each of the merchants" do
    market.merchants.each do |merchant|
      market.zips.include?(merchant.zip).should == true
    end
  end

  describe "#all_csa_zipcodes" do
    it "returns an array of core selling area zipcodes for the market" do
      market.all_csa_zipcodes.class.should == Array
    end

    it "returns all CSA zip codes for the market" do
      market.csa_zips.each do |csa_zip|
        market.all_csa_zipcodes.include?(csa_zip.csa_zipcode).should == true
      end
    end
  end

end
