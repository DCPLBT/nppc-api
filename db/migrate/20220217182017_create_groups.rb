# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :role, null: false, foreign_key: true
      t.references :region, foreign_key: true
      t.references :district, foreign_key: true
      t.references :extension, foreign_key: true
      t.references :village, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
