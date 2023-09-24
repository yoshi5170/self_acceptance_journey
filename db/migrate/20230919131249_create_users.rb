# frozen_string_literal: true
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid, null: false
      t.string :nickname, null: false
      t.string :name, null: false
      t.timestamps null: false
    end

    add_index :users, :uid, unique: true
  end
end
