class AddShownToFolders < ActiveRecord::Migration
  def self.up
    add_column :folders, :shown, :boolean
    add_column :folders, :alter_name, :string
  end

  def self.down
    remove_column :folders, :alter_name
    remove_column :folders, :shown
  end
end
