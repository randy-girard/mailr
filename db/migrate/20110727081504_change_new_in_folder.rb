class ChangeNewInFolder < ActiveRecord::Migration
  def self.up
    rename_column :folders,:new,:unseen
  end

  def self.down
    rename_column :folders,:unseen,:new
  end
end
