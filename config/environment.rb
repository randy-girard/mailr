# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mailr::Application.initialize!

require 'imapmailbox'
Rails.logger = Logger.new(STDOUT)

[IMAPMailbox, IMAPFolderList, IMAPFolder].each { |mod| mod.logger ||= Logger.new(STDOUT) }
