# frozen_string_literal: true

class AddDisabledToMasters < ActiveRecord::Migration[6.1]
  def change
    add_column :regions, :disabled, :boolean, default: false
    add_column :districts, :disabled, :boolean, default: false
    add_column :extensions, :disabled, :boolean, default: false
    add_column :villages, :disabled, :boolean, default: false
    add_column :companies, :disabled, :boolean, default: false
    add_column :agencies, :disabled, :boolean, default: false
    add_column :designations, :disabled, :boolean, default: false
    add_column :employee_types, :disabled, :boolean, default: false
    add_column :product_types, :disabled, :boolean, default: false
    add_column :products, :disabled, :boolean, default: false
    add_column :units, :disabled, :boolean, default: false
  end
end
