# frozen_string_literal: true

class CreateMobilizations < ActiveRecord::Migration[6.1]
  def change
    create_table :mobilizations do |t|
      t.references :region, foreign_key: true
      t.references :district, foreign_key: true
      t.references :extension, foreign_key: true
      t.references :company, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :approved_by
      t.integer :category
      t.integer :state
      t.string :reference_no

      t.timestamps
    end
  end
end
