class CreateMedia < ActiveRecord::Migration[6.0]
  def change
    create_table :media do |t|
      t.string :name
      t.text :description
      t.boolean :is_deleted, defaut: false
      t.timestamps
    end
  end
end
