class Contact < ActiveRecord::Base

    validates_length_of :nick, :within => 5..15
    validates_length_of :first_name,:last_name, :within => 3..20
    validates_length_of :email, :within => 5..50
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    validates_length_of :info, :maximum => 50
    validate_on_create :check_unique_nick

    belongs_to :user

    def self.getPageForUser(user,page,sort_field,sort_dir)

        order = 'last_name asc'
        if sort_field
            if Contact.attribute_method?(sort_field) == true
                order = sort_field
                sort_dir == 'desc' ? order += ' desc' : sort_dir
            end
        end

        Contact.paginate :page => page , :per_page => $defaults["contacts_per_page"], :conditions=> ['user_id = ?', user.id],:order => order
    end

    def full_name
        first_name + ' ' + last_name
    end

    def check_unique_nick
        if !Contact.where('upper(nick) = ? and user_id = ?',nick.upcase,user_id).size.zero?
            errors.add(:nick, :not_unique)
        end
    end

end
