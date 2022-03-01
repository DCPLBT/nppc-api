# frozen_string_literal: true

class AddReferencesToMasters < ActiveRecord::Migration[6.1]
  def change
    add_reference :employee_types, :role, foreign_key: true
    add_reference :agencies, :employee_type, foreign_key: true
    add_reference :designations, :agency, foreign_key: true
  end
end
