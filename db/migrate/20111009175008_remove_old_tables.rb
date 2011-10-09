class RemoveOldTables < ActiveRecord::Migration
  def up
    drop_table :page_ranks
  end

  def down
  end
end
