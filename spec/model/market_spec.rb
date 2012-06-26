require 'spec_helper'
describe Market do

  let!(:market) {Market.create(name:"city")}
  let!(:merchant) { Merchant.create(name: "test") }
  let!(:deal) { market.deals.create(merchant_id: merchant.id, revenue: 50, date_added: Date.today)}
  let!(:deal1) { market.deals.create(merchant_id: merchant.id, revenue: 5, date_added: Date.today-20)}

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
end