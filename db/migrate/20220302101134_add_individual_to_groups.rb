# frozen_string_literal: true

class AddIndividualToGroups < ActiveRecord::Migration[6.1]
  def change
    add_reference :groups, :individual
  end
end
