# frozen_string_literal: true

class CreateIndents < ActiveRecord::Migration[6.1]
  def change
    create_table :indents do |t|
      t.references :stock, foreign_key: true
      t.references :region, foreign_key: true
      t.references :district, foreign_key: true
      t.references :extension, foreign_key: true
      t.boolean :draft
      t.integer :state
      t.string :reference_no

      t.timestamps
    end
  end
end
