# frozen_string_literal: true

class AddMiddlenameToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :middlename, :string
  end
end
