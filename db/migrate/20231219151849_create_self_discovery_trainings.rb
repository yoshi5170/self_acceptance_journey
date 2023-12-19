class CreateSelfDiscoveryTrainings < ActiveRecord::Migration[7.0]
  def change
    create_table :self_discovery_trainings do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :trained_at, null: false

      t.timestamps
    end
  end
end
