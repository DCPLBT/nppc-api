# frozen_string_literal: true

class AddGroupToIndents < ActiveRecord::Migration[6.1]
  def change
    add_column :indents, :from_id, :bigint
    add_column :indents, :to_id, :bigint
  end
end
