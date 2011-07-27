require 'imap_session'
require 'imap_mailbox'

class MessagesController < ApplicationController

	include ImapMailboxModule
	include ImapSessionModule

	before_filter :check_current_user ,:selected_folder

	before_filter :open_imap_session, :only => :refresh
	after_filter :close_imap_session, :only => :refresh

	theme :theme_resolver

	def index
		@folders = @current_user.folders.order("name asc")
		@current_folder = @current_user.folders.current(@selected_folder)
	end

	def refresh
        @current_user.folders.destroy_all
        folders=@mailbox.folders
        Folder.createBulk(@current_user,folders)
        redirect_to :action => 'index'
	end

	def folder
        session[:selected_folder] = params[:id]
        redirect_to :action => 'index'
	end

end
