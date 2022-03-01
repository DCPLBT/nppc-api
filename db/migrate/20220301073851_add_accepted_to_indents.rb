# frozen_string_literal: true

class AddAcceptedToIndents < ActiveRecord::Migration[6.1]
  def change
    add_reference :indents, :accepted_by
    add_column :indents, :accepted_on, :datetime
  end
end
