require 'spec_helper'
describe Merchant do

  let!(:merchant) { Merchant.create(name: "test") }
  let!(:deal) { Deal.create(merchant_id: merchant.id, provider: "livingsocial", revenue: 50)}
  let!(:deal1) { Deal.create(merchant_id: merchant.id, provider: "poop-on", revenue: 5)}

  describe "#providers" do
    it "returns an array with the merchants deal providers" do
        merchant.providers.class.should == Array
    end
    it "should return an Array of two for a merchant with two providers" do
      merchant.providers.count.should == 2
    end
  end

  describe "#run_with_ls?" do
    it "should return a boolean value" do
      merchant.run_with_ls?.class == TrueClass || FalseClass
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

  describe "#total_revenue" do
    it "should return a sum of the total revenue" do
      merchant.total_revenue.should == 55
    end
  end
end



