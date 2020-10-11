class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|

      t.string :name
      t.text :description
      t.references :user
      t.references :category
      t.references :medium
      t.references :material
      t.references :art_era
      t.integer :status, :default =>  0


      t.timestamps
    end
  end
end
