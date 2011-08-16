class RenameMEssagesInFolder < ActiveRecord::Migration
  def self.up
    rename_column :folders,:messages,:total
  end

  def self.down
    rename_column :folders,:total,:messages
  end
end
