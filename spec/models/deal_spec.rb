require 'spec_helper'
describe Deal do

  let!(:merchant) { Merchant.create(name: "test") }
  let!(:deal) { Deal.create(merchant_id: merchant.id, provider: "livingsocial")}
  let!(:deal1) { Deal.create(merchant_id: merchant.id, provider: "poop-on")}
  let!(:offer) {deal.offers.create(revenue: 50, sold: 3)}
  let!(:offer1) {deal1.offers.create(revenue: 5, sold: 4)}

  describe "#merchant_deal_count" do
    it "returns an the number of deals that this deal's merchant has run" do
        deal.merchant_deal_count.should == 2
    end
  end

  describe "#standardize_provider" do
    let!(:deal2) { Deal.create(merchant_id: merchant.id, provider: "Living Social")}
    let!(:deal3) { Deal.create(merchant_id: merchant.id, provider: "Groupon Live")}
    it "returns the correct format for a livingsocial deal" do
      deal2.standardize_provider
      deal2.provider.should == "livingsocial"
    end
    it "returns the correct format for a Groupon deal" do
      deal3.standardize_provider
      deal3.provider.should == "Groupon"
    end
  end

  describe "#sold" do
  	it "returns the total number sold for the deal" do
  		deal.sold.class.should == Fixnum
  	end
  end
end