# frozen_string_literal: true

class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.boolean :default, default: false
      t.string :type
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
