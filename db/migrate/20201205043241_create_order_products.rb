class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :buyer_id
      t.integer :seller_id
      t.boolean :is_canceled, default: false
      t.boolean :is_return, default: false
      t.boolean :is_returned, default: false
      t.timestamps
    end
  end
end
