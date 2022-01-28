# frozen_string_literal: true

class CreateRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :recipients do |t|
      t.references :notification, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :read, default: false
      t.datetime :read_at

      t.timestamps
    end
  end
end
