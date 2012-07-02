class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :merchant_id
      t.integer :market_id
      t.boolean :gmaps
      t.integer :yipit_deal_id
      t.date :date_added
      t.date :date_ended
      t.string :provider
      t.string :full_title
      t.string :short_title
      t.string :deal_url
      t.string :category

      t.timestamps
    end
  end
end
