class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.boolean :default, default: false
      t.references :attachable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
