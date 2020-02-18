class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.boolean :default, default: false
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
