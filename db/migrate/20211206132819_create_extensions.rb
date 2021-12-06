# frozen_string_literal: true

class CreateExtensions < ActiveRecord::Migration[6.1]
  def change
    create_table :extensions do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :district, null: false, foreign_key: true

      t.timestamps
    end
  end
end
