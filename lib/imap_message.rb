require 'net/imap'

module ImapMessageModule

class IMAPAddress

    attr_accessor :name,:mailbox,:host

    def initialize()
        name = ""
        mailbox = ""
        host = ""
    end

    def self.from_address(addr)
        a = IMAPAddress.new()
        a.name = addr.name || ""
        a.mailbox = addr.mailbox || ""
        a.host = addr.host || ""
        a
    end

    def to_db
        name + "#" + mailbox + "#" + host
    end

    def self.parse(addr)
        a = IMAPAddress.new()
        f = addr.split("#")
        a.name = f[0]
        a.mailbox = f[1]
        a.host = f[2]
        a
    end

    def friendly
        if name.empty?
            mailbox + host
        else
            name
        end
    end

end

end

