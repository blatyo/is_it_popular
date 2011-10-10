class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :service
      t.string :kind
      t.integer :value
      t.integer :popularity
      t.belongs_to :site

      t.timestamps
    end
    add_index :stats, :site_id
  end
end
