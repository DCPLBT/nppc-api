# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.references :cartable, polymorphic: true, null: false
      t.decimal :quantity
      t.decimal :amount
      t.bigint :session_id

      t.timestamps
    end
  end
end
