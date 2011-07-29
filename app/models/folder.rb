class Folder < ActiveRecord::Base

    belongs_to :user
    validates_presence_of :name, :on => :create
    before_save :check_fill_params, :on => :create

    def full_name
        if parent.empty?
            name
        else
            parent + delim + name
        end
    end

    def depth
        parent.split('.').size
    end

    private

    def check_fill_params
        self.messages.nil? ? self.messages = 0 : self.messages
        self.unseen.nil? ? self.unseen = 0 : self.unseen
        self.msgs_updated_at.nil? ? self.msgs_updated_at = (DateTime.now-1) : self.msgs_updated_at
    end

    def self.createBulk(user,imapFolders)
        imapFolders.each do |name,data|
        data.attribs.find_index(:Haschildren).nil? ? has_children = 0 : has_children = 1
        name_fields = name.split(data.delim)

        if name_fields.count > 1
            name = name_fields.delete_at(name_fields.size - 1)
            parent = name_fields.join(data.delim)
        else
            name = name_fields[0]
            parent = ""
        end

        logger.info "******************* #{name}, #{parent} "

        user.folders.create(:name=>name,:parent=>parent,:haschildren=>has_children,:delim=>data.delim,:messages => data.messages,:unseen => data.unseen)
        end
    end

    def self.current(data)
        folder = data.split("#")
        if folder.size > 1
            where(['name = ? and parent = ?',folder[1],folder[0]]).first
        else
            where(['name = ?',folder[0]]).first
        end
    end



end
