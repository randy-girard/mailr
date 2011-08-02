class Message < ActiveRecord::Base
    belongs_to :user

    #cattr_reader :per_page
    #@@per_page = $defaults["msgs_per_page"]

    def self.getPageForUser(user,page,order = "date desc")
        #Message.paginate :page => page , :per_page => user.prefs.msgs_per_page.to_i, :conditions=> ['user_id = ?', user.id],:order => order

        Message.paginate :page => page , :per_page => 50, :conditions=> ['user_id = ?', user.id],:order => order
    end

end
