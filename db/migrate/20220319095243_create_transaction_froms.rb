# frozen_string_literal: true

class CreateTransactionFroms < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_froms do |t|
      t.references :transactionable, polymorphic: true, null: false
      t.references :from
      t.string :type

      t.timestamps
    end
  end
end
