class AddAvatarToUserDetail < ActiveRecord::Migration[6.0]
  def change
    add_attachment :user_details, :avatar
  end
end
