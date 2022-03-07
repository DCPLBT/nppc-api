# frozen_string_literal: true

class AddColumnsToMobilizations < ActiveRecord::Migration[6.1]
  def change
    add_reference :mobilizations, :received_by
    add_column :mobilizations, :received_on, :datetime
    add_column :mobilizations, :approved_on, :datetime
  end
end
