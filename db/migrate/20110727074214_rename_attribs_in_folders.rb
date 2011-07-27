class RenameAttribsInFolders < ActiveRecord::Migration
  def self.up
    rename_column :folders,:attribs,:haschildren
    change_column :folders,:haschildren,:boolean
  end

  def self.down
    change_column :folders,:haschildren,:string
    rename_column :folders,:haschildren,:attribs
  end
end
