class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.boolean :default, default: false
      t.references :clipable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
