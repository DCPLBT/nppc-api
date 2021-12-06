# frozen_string_literal: true

class AddCidToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :cid, :string
  end
end
