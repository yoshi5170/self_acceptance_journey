class CreatePlantedFlowers < ActiveRecord::Migration[7.0]
  def change
    create_table :planted_flowers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :flower, null: false, foreign_key: true
      t.datetime :added_at, null: false

      t.timestamps
    end
  end
end
