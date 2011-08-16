class RemoveMsgsUpdateFromMessages < ActiveRecord::Migration
  def self.up
    remove_column :folders, :msgs_updated_at
  end

  def self.down
    add_column :folders, :msgs_updated_at, :datetime
  end
end
