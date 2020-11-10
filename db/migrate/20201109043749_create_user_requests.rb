class CreateUserRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :user_requests do |t|
      t.references :user
      t.references :request
    end
  end
end
