require 'spec_helper'
describe Merchant do

  let!(:merchant) { Merchant.create(name: "test") }
  let!(:deal) { Deal.create(merchant_id: merchant.id, provider: "livingsocial", revenue: 50, date_added: Date.strptime("10/04/1988", "%m/%d/%Y"))}
  let!(:deal1) { Deal.create(merchant_id: merchant.id, provider: "poop-on", revenue: 5, date_added: Date.strptime("10/04/2005", "%m/%d/%Y"))}

  describe "#providers" do
    it "returns an array with the merchants deal providers" do
        merchant.providers.class.should == Array
    end
    it "should return an Array of two for a merchant with two providers" do
      merchant.providers.count.should == 2
    end
  end

  describe "#revenues" do
    it "returns an array with the merchants deal revenues" do
        merchant.revenues.class.should == Array
    end
    it "should return an Array of two for a merchant with two deals with revenue" do
      merchant.revenues.count.should == 2
    end

    it "should return an Array of numbers" do
      merchant.revenues.each do |revenue|
        revenue.class.should == Float
      end
    end
  end

  describe "#run_with_ls?" do
    it "should return a boolean value representing if the merchant has ever run with ls" do
      merchant.run_with_ls?.should == true
    end
  end

  describe "#run_with_gpn?" do
    it "should return a boolean value representing if the merchant has ever run with gpn" do
      merchant.run_with_gpn?.should == false
    end
  end

  describe "#third_party_only?" do
    it "should return a boolean value representing if the merchant has only run with third parties" do
      merchant.third_party_only?.should == false
    end
  end

  describe "#days_since_all_runs" do
    it "should return an array" do
      merchant.days_since_all_runs.class.should == Array
    end

    it "should return an array of integers representing the days since each of the merchants runs" do
      merchant.days_since_all_runs.each do |days|
        days.class.should == Fixnum
      end
    end
  end

  describe "#most_recent_run_date" do
    it "returns the run date of the most recent deal run" do
      merchant.most_recent_run_date.should == Date.strptime("10/04/2005", "%m/%d/%Y")
    end

    it "returns a Date object" do
      merchant.most_recent_run_date.class.should == Date
    end
  end

  describe "providers_to_comma" do
    it "should return a string" do
      merchant.providers_to_comma.class == String
    end

    it "should return a string containing the value of each provider" do
      merchant.providers.each do |provider|
        merchant.providers_to_comma.include?(provider).should == true
      end
    end
  end

  describe "#most_recent_provider" do
    it "should return the provider of the most recent deal run" do
      merchant.most_recent_provider.should == "poop-on"
    end
  end

  describe "#total_revenue" do
    it "should return a sum of the total revenue" do
      merchant.total_revenue.should == 55
    end
  end
end



