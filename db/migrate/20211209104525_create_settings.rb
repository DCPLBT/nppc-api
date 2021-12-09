# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :meta
      t.integer :category

      t.timestamps
    end
  end
end
