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
      t.float :price
      t.float :value
      t.float :discount
      t.integer :sold
      t.string :sold_out
      t.string :revenue
      t.string :revenue_index
      t.string :deal_url
      t.string :category
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end