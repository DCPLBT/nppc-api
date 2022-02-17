# frozen_string_literal: true

class CreateVillages < ActiveRecord::Migration[6.1]
  def change
    create_table :villages do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :extension, null: false, foreign_key: true

      t.timestamps
    end
  end
end
