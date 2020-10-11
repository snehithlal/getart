class CreateMinorcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :minorcategories do |t|
      t.string :name
      t.text :description
      t.references :subcategory, foreign_key: true

      t.timestamps
    end
  end
end
