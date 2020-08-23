class CreateUserDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :user_details do |t|
      t.integer :user_id
      t.string :full_name
      t.string :email_id
      t.string :phone_no
      t.timestamps
    end
  end
end
