class CreateDiaryEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :diary_entries do |t|
      t.string :content, null: false
      t.references :diary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
