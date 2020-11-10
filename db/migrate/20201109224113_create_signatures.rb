class CreateSignatures < ActiveRecord::Migration[5.1]
  def change
    create_table :signatures do |t|
      t.string :encrypted_key,      null: false
      t.references :user,           foreign_key: true

      t.timestamps
    end
  end
end
