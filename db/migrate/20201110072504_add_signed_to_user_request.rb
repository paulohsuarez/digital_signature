class AddSignedToUserRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :user_requests, :signed, :boolean, default: false
  end
end
