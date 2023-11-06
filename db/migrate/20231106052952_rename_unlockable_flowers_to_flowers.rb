class RenameUnlockableFlowersToFlowers < ActiveRecord::Migration[7.0]
  def change
    rename_table :unlockable_flowers, :flowers
  end
end
