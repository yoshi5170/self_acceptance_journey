class CreateUnlockableFlowers < ActiveRecord::Migration[7.0]
  def change
    create_table :unlockable_flowers do |t|
      t.string :name, null: false
      t.integer :threshold, null: false

      t.timestamps
    end
  end
end
