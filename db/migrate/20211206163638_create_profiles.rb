# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.integer :gender
      t.integer :employee_type
      t.integer :designation
      t.integer :agency
      t.string :employee_id
      t.references :region, foreign_key: true
      t.references :district, foreign_key: true
      t.references :extension, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
