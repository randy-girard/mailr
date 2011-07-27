class CreateFolders < ActiveRecord::Migration
  def self.up
    create_table :folders do |t|
      t.string :name
      t.string :delim
      t.string :attribs
      t.integer :messages
      t.integer :new
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :folders
  end
end
