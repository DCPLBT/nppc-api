# frozen_string_literal: true

class CreateTransactionTos < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_tos do |t|
      t.references :transactionable, polymorphic: true, null: false
      t.references :to
      t.string :type

      t.timestamps
    end
  end
end
