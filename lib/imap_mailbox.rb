require 'net/imap'
require 'imap_folder'

module ImapMailboxModule

class IMAPError < RuntimeError
end

class IMAPMailbox

	attr_reader :connected
	attr_accessor :selected_folder
	attr_accessor :logger

	def initialize(logger)
		@selected_folder = ''
		@folders = {}
		@connected = false
		@logger = logger
	end

	def connect(server,username,password)

        server_name = server.name
        server_port = server.port
        server_use_ssl = server.use_ssl

		unless @connected
			begin
				@imap = Net::IMAP.new(server_name, server_port, server_use_ssl)
			rescue Net::IMAP::ByeResponseError => bye
				begin
					System.sleep($defaults["imap_bye_timeout_retry_seconds"])
					@imap = Net::IMAP.new(server_name, server_port, server_use_ssl)
				rescue Exception => ex
					raise IMAPError, ex.inspect
				end
			rescue Exception => ex
				raise IMAPError, ex.inspect
			end
			@username = username
			begin
				@imap.login(username, password)
				@connected = true
			rescue Exception => ex
				raise IMAPError, ex.inspect
			end
		end
	end

	def disconnect
		 if @connected
			@imap.logout
			@imap.disconnect
			@imap = nil
			@connected = false
		 end
	end

    def folders
        @folders = {}
        folders = @imap.list('', '*')
        if folders
            folders.each do |f|
                folder = ImapFolderModule::IMAPFolder.new(f.name,f.delim,f.attr)
                status = @imap.status(folder.name, ["MESSAGES", "UNSEEN"])
                folder.messages = status["MESSAGES"]
                folder.unseen = status["UNSEEN"]
                @folders[folder.name] = folder
            end
        end
        @folders
    end

    def create_folder(name)
        begin
            @imap.create(Net::IMAP.encode_utf7(name))
        rescue Exception => e
            raise e
        end
    end

    def delete_folder(name)
        begin
            @imap.delete(Net::IMAP.decode_utf7(name))
        rescue Exception => e
            raise e
        end
    end

    def fetch(folder_name,range,attribs)
        begin
            set_folder(folder_name)
            @imap.fetch(range,attribs)
        rescue Exception => e
            raise e
        end
    end

    def uid_fetch(folder_name,range,attribs)
        begin
            set_folder(folder_name)
            @imap.uid_fetch(range,attribs)
        rescue Exception => e
            raise e
        end
    end

    def set_folder(folder_name)
        if folder_name.downcase != @selected_folder.downcase
            @imap.select(folder_name)
            @selected_folder = folder_name
        end
    end

    def status(folder_name)
        @imap.status(folder_name, ["MESSAGES", "RECENT", "UNSEEN"])
    end

    def fetch_body(folder_name,uid)
        uid_fetch(folder_name,uid,"BODY[]").first.attr["BODY[]"]
    end

end

end
