class AddParamsToPrefs < ActiveRecord::Migration
  def self.up
    add_column :prefs, :msgs_per_page, :string
    add_column :prefs, :msg_send_type, :string
  end

  def self.down
    remove_column :prefs, :msg_send_type
    remove_column :prefs, :msgs_per_page
  end
end
