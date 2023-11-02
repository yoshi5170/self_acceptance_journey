class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.integer :score_range_start, null: false
      t.integer :score_range_end, null: false
      t.text :description, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
