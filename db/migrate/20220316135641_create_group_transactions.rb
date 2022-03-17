# frozen_string_literal: true

class CreateGroupTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :group_transactions do |t|
      t.references :transactionable, polymorphic: true, null: false
      t.references :group, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
