class AddStatusToRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :status, :string, default: "Pendente"
  end
end
