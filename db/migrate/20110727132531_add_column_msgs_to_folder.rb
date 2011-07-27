class AddColumnMsgsToFolder < ActiveRecord::Migration
  def self.up
    add_column :folders, :msgs_updated_at, :datetime
  end

  def self.down
    remove_column :folders, :msgs_updated_at
  end
end
