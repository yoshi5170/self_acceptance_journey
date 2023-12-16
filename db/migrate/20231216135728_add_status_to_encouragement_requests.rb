class AddStatusToEncouragementRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :encouragement_requests, :status, :integer, null: false, default: 0
  end
end
