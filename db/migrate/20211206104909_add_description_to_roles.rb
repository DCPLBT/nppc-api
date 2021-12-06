# frozen_string_literal: true

class AddDescriptionToRoles < ActiveRecord::Migration[6.1]
  def change
    add_column :roles, :description, :text
  end
end
