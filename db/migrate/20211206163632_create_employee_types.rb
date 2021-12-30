# frozen_string_literal: true

class CreateEmployeeTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_types do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
