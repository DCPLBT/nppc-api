# frozen_string_literal: true

class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.references :product_type, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :itemable, polymorphic: true, null: false
      t.decimal :quantity
      t.decimal :unit_price
      t.string :unit

      t.timestamps
    end
  end
end
