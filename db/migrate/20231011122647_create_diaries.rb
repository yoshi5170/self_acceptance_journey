class CreateDiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :diaries do |t|
      t.datetime :date, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
