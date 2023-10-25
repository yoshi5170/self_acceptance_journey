class CreateMonthlyThemes < ActiveRecord::Migration[7.0]
  def change
    create_table :monthly_themes do |t|
      t.integer :month, null: false
      t.string :title, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
