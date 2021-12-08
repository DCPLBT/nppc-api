# frozen_string_literal: true

class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.references :product_type, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :quantity
      t.string :unit
      t.decimal :unit_price
      t.date :expiry_date
      t.date :procured_on
      t.date :obsolete_date
      t.text :remark

      t.timestamps
    end
  end
end
