# frozen_string_literal: true

class AddColumnsToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :line_items, :received_by
    add_column :line_items, :received, :boolean, default: false
    add_column :line_items, :received_on, :datetime
    add_column :line_items, :received_quantity, :decimal
  end
end
