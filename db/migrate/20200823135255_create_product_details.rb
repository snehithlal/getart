class CreateProductDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :product_details do |t|

      t.references :product
      t.references :size
      t.integer :orientation
      t.timestamps
    end
  end
end
