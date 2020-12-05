class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :slug
      t.integer :user_detail_id
      t.timestamps
    end
  end
end
