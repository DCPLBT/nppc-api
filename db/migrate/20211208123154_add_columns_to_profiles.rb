# frozen_string_literal: true

class AddColumnsToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :employee_type, :integer
    add_column :profiles, :employee_id, :string
    add_column :profiles, :designation, :integer
    add_column :profiles, :agency, :integer
  end
end
