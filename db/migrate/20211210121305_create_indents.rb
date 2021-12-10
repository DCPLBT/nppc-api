# frozen_string_literal: true

class CreateIndents < ActiveRecord::Migration[6.1]
  def change
    create_table :indents do |t|
      t.references :product_type, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :requester
      t.references :forwarded_to
      t.decimal :quantity
      t.string :unit
      t.boolean :draft
      t.integer :state

      t.timestamps
    end
  end
end
