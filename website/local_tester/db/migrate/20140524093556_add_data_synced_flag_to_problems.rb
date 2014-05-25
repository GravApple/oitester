class AddDataSyncedFlagToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :data_synced, :boolean
  end
end
