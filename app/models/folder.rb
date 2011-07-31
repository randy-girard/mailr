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

    def selected?(session_folder)
		fields = session_folder.split("#")
		fields[1].nil? ? fields.insert(0,"") : fields
		(fields[1].downcase == name.downcase) && (fields[0].downcase == parent.downcase)
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

        user.folders.create(:name=>name,:parent=>parent,:haschildren=>has_children,:delim=>data.delim,:messages => data.messages,:unseen => data.unseen)
        end
    end

    def self.current(data)
        folder = data.split("#")
        nam = folder.delete_at(folder.size - 1)
        folder.size.zero? == true ? par = "" : par = folder.join(".")
		where(['name = ? and parent = ?',nam,par]).first
    end

    def self.shown
		where(['shown = ?',true])
	end

	def self.refresh(mailbox,user)
        user.folders.destroy_all
        folders=mailbox.folders
        Folder.createBulk(user,folders)
	end

end
