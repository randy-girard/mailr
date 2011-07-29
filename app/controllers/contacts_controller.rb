require 'imap_session'
require 'imap_mailbox'

class ContactsController < ApplicationController

    include ImapMailboxModule
	include ImapSessionModule

	before_filter :check_current_user,:selected_folder

	before_filter :open_imap_session
	after_filter :close_imap_session

	theme :theme_resolver

    def index
        @folders = @current_user.folders.order("name asc")
		@current_folder = @current_user.folders.current(@selected_folder)
		flash[:notice] = 'Not implemented yet'
    end

end
