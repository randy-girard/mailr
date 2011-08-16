class RenameFromColumnInMessages < ActiveRecord::Migration
  def self.up
    rename_column :messages, :from, :from_addr
    rename_column :messages, :to, :to_addr
  end

  def self.down
    rename_column :messages, :from_addr, :from
    rename_column :messages, :to_addr, :to
  end
end
