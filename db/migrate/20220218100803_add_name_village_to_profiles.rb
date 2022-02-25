# frozen_string_literal: true

class AddNameVillageToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :name, :string
    add_reference :profiles, :village, foreign_key: true
    remove_columns :profiles, :firstname, :lastname, :village, type: :string
  end
end
