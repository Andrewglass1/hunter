class CreateCsaZips < ActiveRecord::Migration
  def change
    create_table :csa_zips do |t|
      t.integer :market_id
      t.string  :csa_zipcode
      t.timestamps
    end
  end
end
