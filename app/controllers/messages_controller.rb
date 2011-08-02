require 'imap_session'
require 'imap_mailbox'
require 'imap_message'

class MessagesController < ApplicationController

	include ImapMailboxModule
	include ImapSessionModule
	include ImapMessageModule
    include MessagesHelper

	before_filter :check_current_user ,:selected_folder

	before_filter :get_current_folders, :only => [:index,:compose,:show]

	before_filter :open_imap_session, :only => :refresh
	after_filter :close_imap_session, :only => :refresh

	theme :theme_resolver

	@@fetch_attr = ['ENVELOPE','BODYSTRUCTURE', 'FLAGS', 'UID', 'RFC822.SIZE']

	def index

        open_imap_session
        ####################
        @messages = []

        folder_status = @mailbox.status(@current_folder.full_name)
        @current_folder.update_attributes(:messages => folder_status['MESSAGES'], :unseen => folder_status['UNSEEN'])

        if folder_status['MESSAGES'].zero?
            return
        end

        messages = @mailbox.fetch(@current_folder.full_name,1..-1, "UID")
        logger.custom('mess',messages)
        uids_to_be_fetched = []

        messages.each do |m|
            uids_to_be_fetched << m.attr['UID']
        end

        messages = []
        @current_user.messages.destroy_all
        uids_to_be_fetched.each_slice($defaults["imap_fetch_slice"].to_i) do |slice|
            logger.custom('slice',slice.join(","))
            messages = @mailbox.uid_fetch(@current_folder.full_name,slice, @@fetch_attr)



            messages.each do |m|

            envelope = m.attr['ENVELOPE']
            uid = m.attr['UID']
            #content_type = m.attr['BODYSTRUCTURE'].multipart? ? 'multipart' : 'text'
            content_type = m.attr['BODYSTRUCTURE'].media_type.downcase
            size = m.attr['RFC822.SIZE']
            unread = !(m.attr['FLAGS'].member? :Seen)
            from = ImapMessageModule::IMAPAddress.from_address(envelope.from[0])
            logger.custom('from',from.to_db)
            logger.custom('enevelope_from',envelope)
            logger.custom('body',m.attr['BODYSTRUCTURE'])
            message = @current_user.messages.create(:folder_id => @current_folder.id,
                                                    :msg_id => envelope.message_id,
                                                    :uid => uid,
                                                    :from => from.to_db,
                                                    :to => envelope.to,
                                                    :subject => envelope.subject,
                                                    :content_type => content_type,
                                                    :date => envelope.date,
                                                    :unread => unread,
                                                    :size => size)

            end

        end

        @messages = Message.getPageForUser(@current_user,params['page'])

        ###############
        close_imap_session
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

	def ops
        redirect_to :action => 'index'
    end

    def show
        @message = Message.find(params[:id])
        flash[:notice] = 'Not impelented yet'
        open_imap_session
        @body = @mailbox.fetch_body(@current_folder.full_name,@message.uid)
        logger.custom('body',@body.inspect)
        close_imap_session
    end

end
