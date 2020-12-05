class CreateMinorcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :minorcategories do |t|
      t.string :name
      t.text :description
      t.references :subcategory, foreign_key: true
      t.boolean :is_deleted, defaut: false
      t.timestamps
    end
  end
end
