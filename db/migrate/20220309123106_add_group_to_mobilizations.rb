# frozen_string_literal: true

class AddGroupToMobilizations < ActiveRecord::Migration[6.1]
  def change
    add_reference :mobilizations, :from
    add_reference :mobilizations, :to
  end
end
