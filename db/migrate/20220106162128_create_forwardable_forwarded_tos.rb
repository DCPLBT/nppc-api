# frozen_string_literal: true

class CreateForwardableForwardedTos < ActiveRecord::Migration[6.1]
  def change
    create_table :forwardable_forwarded_tos do |t|
      t.references :forwardable, polymorphic: true, null: false
      t.references :forwarded_to, null: false

      t.timestamps
    end
  end
end
