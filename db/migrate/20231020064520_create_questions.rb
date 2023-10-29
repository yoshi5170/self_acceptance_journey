class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :text, null: false
      t.integer :score_type, default: 0, null: false

      t.timestamps
    end
  end
end
