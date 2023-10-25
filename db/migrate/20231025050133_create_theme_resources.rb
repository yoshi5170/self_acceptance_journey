class CreateThemeResources < ActiveRecord::Migration[7.0]
  def change
    create_table :theme_resources do |t|
      t.references :monthly_theme, null: false, foreign_key: true
      t.string :content, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
