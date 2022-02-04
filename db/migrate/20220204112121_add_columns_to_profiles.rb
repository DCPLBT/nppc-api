# frozen_string_literal: true

class AddColumnsToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :village, :string
    add_column :profiles, :occupation, :string
    add_column :profiles, :dob, :date
    add_column :profiles, :mother_name, :string
    add_column :profiles, :father_name, :string
  end
end
