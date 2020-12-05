class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.references :product_details
      t.float :price_by_seller
      t.float :price_by_admin
      t.integer :count, default:  0
      t.timestamps
    end
  end
end
