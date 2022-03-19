# frozen_string_literal: true

class AddForwardedAndReceivedToIndents < ActiveRecord::Migration[6.1]
  def change
    add_reference :indents, :forwarded_by
    add_column :indents, :forwarded_on, :datetime
    add_reference :indents, :received_by
    add_column :indents, :received_on, :datetime
  end
end
