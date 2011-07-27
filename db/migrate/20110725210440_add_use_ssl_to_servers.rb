class AddUseSslToServers < ActiveRecord::Migration
  def self.up
	add_column :servers, :use_ssl, :boolean
  end

  def self.down
	remove_column :servers, :use_ssl, :boolean
  end
end
