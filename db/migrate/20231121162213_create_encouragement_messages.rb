class CreateEncouragementMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :encouragement_messages do |t|
      t.references :encouragement_request, null: false, foreign_key: true
      t.string :text, null: false
      t.integer :background_id, null: false
      t.timestamps
    end
  end
end
