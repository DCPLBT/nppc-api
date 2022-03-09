# frozen_string_literal: true

class AddGroupsToDistributions < ActiveRecord::Migration[6.1]
  def change
    add_reference :distributions, :from
    add_reference :distributions, :to
    add_reference :distributions, :village, foreign_key: true
  end
end
