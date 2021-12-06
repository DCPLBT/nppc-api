# frozen_string_literal: true

class CreateDistricts < ActiveRecord::Migration[6.1]
  def change
    create_table :districts do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :region, foreign_key: true

      t.timestamps
    end
  end
end
