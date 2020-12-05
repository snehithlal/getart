class CreateSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.text :description
      t.references :category, foreign_key: true
      t.boolean :is_deleted, defaut: false
      t.timestamps
    end
  end
end
