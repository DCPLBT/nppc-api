# frozen_string_literal: true

class AddGroupToSurrenders < ActiveRecord::Migration[6.1]
  def change
    add_reference :surrenders, :from
    add_reference :surrenders, :to
  end
end
