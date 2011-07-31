require 'imap_session'
require 'imap_mailbox'

class MessagesController < ApplicationController

	include ImapMailboxModule
	include ImapSessionModule

	before_filter :check_current_user ,:selected_folder

	before_filter :get_current_folders, :only => [:index,:compose]

	before_filter :open_imap_session, :only => :refresh
	after_filter :close_imap_session, :only => :refresh

	theme :theme_resolver

	def index
		flash[:notice] = 'Not implemented yet'
	end

	def folder
        session[:selected_folder] = params[:id]
        redirect_to :action => 'index'
	end

	def compose
		flash[:notice] = 'Not impelented yet'
	end

	def refresh
		redirect_to :action => 'index'
	end

end
