require 'spec_helper'
describe Deal do

  let!(:merchant) { Merchant.create(name: "test") }
  let!(:deal) { Deal.create(merchant_id: merchant.id, provider: "livingsocial", revenue: 50)}
  let!(:deal1) { Deal.create(merchant_id: merchant.id, provider: "poop-on", revenue: 5)}

  describe "#merchant_deal_count" do
    it "returns an the number of deals that this deal's merchant has run" do
        deal.merchant_deal_count.should == 2
    end
  end

  describe "#standardize_provider" do
    let!(:deal2) { Deal.create(merchant_id: merchant.id, provider: "Living Social", revenue: 50)}
    it "returns the correct format for a livingsocial deal" do
      deal2.standardize_provider
      deal2.provider.should == "livingsocial"
    end
  end
end