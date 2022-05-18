# frozen_string_literal: true

class AddTotalQuantityProcuredToStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :total_quantity_procured, :decimal
  end
end
