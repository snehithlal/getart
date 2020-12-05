class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :user_detail_id
      t.string :full_name
      t.string :mobile
      t.boolean :is_home_adress, default: true
      t.text :address
      t.boolean :last_used, default: false
      t.string :slug
      t.boolean :is_default, default: false
      t.boolean :is_deleted, defaut: false
      t.timestamps
    end
  end
end
