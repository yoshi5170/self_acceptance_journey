class AddUniqueIndexToDiaries < ActiveRecord::Migration[7.0]
  def change
    add_index :diaries, ["user_id", "date"], unique: true
  end
end
