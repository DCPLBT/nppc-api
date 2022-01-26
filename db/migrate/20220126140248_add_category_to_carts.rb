# frozen_string_literal: true

class AddCategoryToCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :category, :integer
  end
end
