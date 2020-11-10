class AddAttachmentDocumentToRequests < ActiveRecord::Migration[5.1]
  def self.up
    change_table :requests do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :requests, :document
  end
end
