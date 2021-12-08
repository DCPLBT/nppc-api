# frozen_string_literal: true

class CreateProductTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :product_types do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
