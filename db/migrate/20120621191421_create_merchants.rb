class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.integer :yipit_merchant_id
      t.string :address
      t.string :city
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.string :phone
      t.string :website

      t.timestamps
    end
  end
end
