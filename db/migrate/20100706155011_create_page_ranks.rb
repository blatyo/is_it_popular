class CreatePageRanks < ActiveRecord::Migration
  def self.up
    create_table :page_ranks do |t|
      t.string :site, :unique => true, :null => false
      t.integer :alexa_rank, :null => false
      t.integer :google_rank, :null => false
      t.integer :alexa_backlinks, :null => false
      t.integer :alltheweb_backlinks, :null => false
      t.integer :altavista_backlinks, :null => false
      t.integer :bing_backlinks, :null => false
      t.integer :google_backlinks, :null => false
      t.integer :yahoo_backlinks, :null => false
      t.timestamps
    end
    
    add_index :page_ranks, :site
  end

  def self.down
    drop_table :page_ranks
  end
end
