module MessagesHelper

    def size_formatter(size)
        if size <= 2**10
            "#{size} #{t(:bytes)}"
        elsif size <= 2**20
            sprintf("%.1f #{t(:kbytes)}",size.to_f/2**10)
        else
            sprintf("%.1f #{t(:mbytes)}",size.to_f/2**20)
        end
    end

    def date_formatter(date)
        date.strftime("%Y-%m-%d %H:%M")
    end

    def address_formatter(addr)
        ImapMessageModule::IMAPAddress.parse(addr).friendly
    end

    def subject_formatter(message)
		length = $defaults["msg_subject_length"].to_i
		logger.custom('l',length)
		message.subject.length >= length ? s = message.subject[0,length]+"..." : s = message.subject
        link_to s,:controller => 'messages', :action => 'show', :id => message.id
    end

    def attachment_formatter(message)
        message.content_type == 'text' ? "" : "A"
    end

end

