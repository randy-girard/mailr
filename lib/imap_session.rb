require 'net/imap'
require 'imap_mailbox'

module ImapSessionModule

def open_imap_session
	begin
		@mailbox ||= ImapMailboxModule::IMAPMailbox.new(logger)
		@mailbox.connect(@current_user.servers.primary,@current_user.email, @current_user.get_cached_password(session))
	rescue Exception => ex
		redirect_to :controller => 'internal', :action => 'loginfailure'
	end
end

def close_imap_session
	return if @mailbox.nil? or not(@mailbox.connected)
	@mailbox.disconnect
	@mailbox = nil
end

end
