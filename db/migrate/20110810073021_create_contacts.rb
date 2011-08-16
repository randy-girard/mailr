class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :nick
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :info
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
