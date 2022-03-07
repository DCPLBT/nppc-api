# frozen_string_literal: true

class AddColumnsToSurrenders < ActiveRecord::Migration[6.1]
  def change
    add_reference :surrenders, :received_by
    add_column :surrenders, :received_on, :datetime
  end
end
