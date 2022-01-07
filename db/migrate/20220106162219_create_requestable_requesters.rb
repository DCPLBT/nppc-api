# frozen_string_literal: true

class CreateRequestableRequesters < ActiveRecord::Migration[6.1]
  def change
    create_table :requestable_requesters do |t|
      t.references :requestable, polymorphic: true, null: false
      t.references :requester, null: false

      t.timestamps
    end
  end
end
