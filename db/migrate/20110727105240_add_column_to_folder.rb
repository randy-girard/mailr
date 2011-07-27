class AddColumnToFolder < ActiveRecord::Migration
  def self.up
    add_column :folders, :parent, :string
  end

  def self.down
    remove_column :folders, :parent
  end
end
