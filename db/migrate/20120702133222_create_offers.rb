class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
    	t.integer :deal_id
    	t.float :price
      t.float :value
      t.float :discount
      t.integer :sold
      t.float :revenue
      t.float :revenue_index
      t.timestamps
    end
  end
end
