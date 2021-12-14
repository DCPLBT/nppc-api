# frozen_string_literal: true

class CreateIndents < ActiveRecord::Migration[6.1]
  def change
    create_table :indents do |t|
      t.references :requester
      t.references :forwarded_to
      t.boolean :draft
      t.integer :state

      t.timestamps
    end
  end
end
