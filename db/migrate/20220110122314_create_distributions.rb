# frozen_string_literal: true

class CreateDistributions < ActiveRecord::Migration[6.1]
  def change
    create_table :distributions do |t|
      t.references :region, foreign_key: true
      t.references :district, foreign_key: true
      t.references :extension, foreign_key: true
      t.references :company, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :distributed_type
      t.string :consumer_ids, array: true
      t.integer :state
      t.string :reference_no
      t.boolean :draft
      t.string :consumer_cid
      t.string :consumer_name
      t.string :consumer_village

      t.timestamps
    end
  end
end
