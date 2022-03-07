# frozen_string_literal: true

class AddIndentTypeToIndents < ActiveRecord::Migration[6.1]
  def change
    add_column :indents, :indent_type, :integer
  end
end
