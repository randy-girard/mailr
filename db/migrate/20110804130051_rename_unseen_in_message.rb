class RenameUnseenInMessage < ActiveRecord::Migration
  def self.up
    rename_column :messages, :unread, :unseen
  end

  def self.down
    rename_column :messages, :unseen, :unread
  end
end
