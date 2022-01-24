# frozen_string_literal: true

class CreateSurrenders < ActiveRecord::Migration[6.1]
  def change
    create_table :surrenders do |t|
      t.references :region, foreign_key: true
      t.references :district, foreign_key: true
      t.references :extension, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :surrender_type
      t.integer :state
      t.string :reference_no

      t.timestamps
    end
  end
end
