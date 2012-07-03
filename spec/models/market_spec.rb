require 'spec_helper'
describe Market do

    before :each do
        Market.any_instance.stub(:calculate_lat_long).and_return("foo")
    end

  context "creating models" do
    
    let!(:market) {Market.create(name:"city")}
    let!(:merchant) { Merchant.create(name: "test", zip: "11753") }
    let!(:deal) { market.deals.create(merchant_id: merchant.id, date_added: Date.today, category: "testcat1", provider: "poop-on")}
    let!(:deal1) { market.deals.create(merchant_id: merchant.id, date_added: Date.today-20, category: "testcat2", provider: "livingsocial")}
    let!(:csa) { market.csa_zips.create(csa_zipcode: "11753")}
    let!(:offer) {deal.offers.create(revenue: 50)}
    let!(:offer1) {deal1.offers.create(revenue: 5)}

    before :each do
      market.stub(:calculate_lat_long).and_return("foo")
    end

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

    describe "#zips_index" do
      it "returns a hash with the zipcodes with deals in the market with their frequency" do
        market.zips_index.each do |zip, frequency|
          zip.class.should == String
          frequency.class.should == Fixnum
        end
      end
    end

    describe "#categories" do
      it "returns an array of the categories from the market" do
        market.categories.class.should == Array
      end

      it "actually contains the catgories from the deals in the market" do
        market.categories.include?("testcat2").should == true
      end
    end

    describe "#categories_index_with_total_revenue" do
      it "returns a hash with the categories and their revenues" do
        market.categories_index_with_total_revenue.each do |category, revenue|
          category.class.should == String
          revenue.class.should == Float
        end
      end
    end

    describe "#graphael_data_categories" do
      it "provides a string which is an array of revenues and a a string which is an array or providers for the chart legend" do
        market.graphael_data_categories[0].class.should == String
        market.graphael_data_categories[1].class.should == String
      end
    end

    describe ".categories_index_with_total_revenue" do
      it "returns a hash with the categories and their revenues" do
        Market.categories_index_with_total_revenue.each do |category, revenue|
          category.class.should == String
          revenue.class.should == Float
        end
      end
    end

    describe ".graphael_data_categories" do
      it "provides a string which is an array of revenues and a a string which is an array of categories for the chart legend" do
        Market.graphael_data_categories[0].class.should == String
        Market.graphael_data_categories[1].class.should == String
      end
    end

    describe "#providers_index_with_total_revenue" do
      it "returns a hash with the providers and their revenues" do
        market.providers_index_with_total_revenue.each do |provider, revenue|
          provider.class.should == String
          revenue.class.should == Float
        end
      end
    end

    describe "#graphael_data_providers" do
      it "provides a string which is an array of revenues and a a string which is an array or providers for the chart legend" do
        market.graphael_data_providers[0].class.should == String
        market.graphael_data_providers[1].class.should == String
      end
    end

    describe ".providers_index_with_total_revenue" do
      it "returns a hash with the providers and their revenues across all markets" do
        Market.providers_index_with_total_revenue.each do |provider, revenue|
          provider.class.should == String
          revenue.class.should == Float
        end
      end
    end

    describe ".graphael_data_providers" do
      it "provides a string which is an array of revenues and a a string which is an array or providers for the chart legend across all markets" do
        Market.graphael_data_providers[0].class.should == String
        Market.graphael_data_providers[1].class.should == String
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
end
