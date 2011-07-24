require 'net/imap'

module ImapUtils

class IMAPMailbox
#
#	attr_reader :connected
#	attr_accessor :selected_mailbox
#	cattr_accessor :logger
#
	def initialize(logger)
#		@selected_mailbox = ''
#		@folders          = {}
#		@connected = false
		@logger = logger
		@logger.info "XXXXXXXXXX i am in"
	end
#
end

def info
	@m = IMAPMailbox.new(logger)
	logger.info "XXXXXXXXXXXXX"
	logger.info @m.inspect
end
#
#def load_imap_session
#	begin
#		@mailbox = IMAPMailbox.new(self.logger)
##      uname = (get_mail_prefs.check_external_mail == 1 ? user.email : user.local_email)
##      upass = get_upass
##      @mailbox.connect(uname, upass)
##      load_folders
#    rescue Exception => ex
#      render :controller => "internal", :action => "error" , :error => ex.inspect
#    end
#end

#	def close_imap_session
#    return if @mailbox.nil? or not(@mailbox.connected)
#    @mailbox.disconnect
#    @mailbox = nil
#  end




end
