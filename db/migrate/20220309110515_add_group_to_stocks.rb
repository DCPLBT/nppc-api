# frozen_string_literal: true

class AddGroupToStocks < ActiveRecord::Migration[6.1]
  def change
    add_reference :stocks, :group, foreign_key: true
  end
end
