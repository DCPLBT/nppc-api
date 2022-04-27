# frozen_string_literal: true

class AddPackSizeToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :pack_size, :string
  end
end
