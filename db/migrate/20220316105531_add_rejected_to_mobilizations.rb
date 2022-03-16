# frozen_string_literal: true

class AddRejectedToMobilizations < ActiveRecord::Migration[6.1]
  def change
    add_reference :mobilizations, :rejected_by
    add_column :mobilizations, :rejected_on, :datetime
  end
end
