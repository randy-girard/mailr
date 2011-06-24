require 'cdfutils'
require_association 'contact_group'

class Contact < ActiveRecord::Base

    validate :check_fname_and_lname, :check_mail_cannot_be_changed
    validate :check_email, :on => :create

  has_and_belongs_to_many :groups, :class_name => "ContactGroup", :join_table => "contact_contact_groups", :association_foreign_key => "contact_group_id", :foreign_key => "contact_id"

  # Finder methods follow
  def Contact.find_by_user(user_id)
    find(:all, :conditions => ["customer_id = ?", user_id], :order => "fname asc", :limit => 10)
  end

  def Contact.find_by_user_email(user_id, email)
    find(:first, :conditions => ["customer_id = #{user_id} and email = ?", email])
  end

  def Contact.find_by_group_user(user_id, grp_id)
    result = Array.new
    find(:all, :conditions => ["customer_id = ?", user_id], :order => "fname asc").each { |c|
      begin
        c.groups.find(grp_id)
        result << c
      rescue ActiveRecord::RecordNotFound
      end
    }
    result
  end

  scope :for_customer, lambda{ |customer_id| {:conditions => {:customer_id => customer_id}} }
  scope :letter, lambda{ |letter| {:conditions => ["contacts.fname LIKE ?", "#{letter}%"]} }

  def Contact.find_by_user_letter(user_id, letter)
    find_by_sql("select * from contacts where customer_id=#{user_id} and substr(UPPER(fname),1,1) = '#{letter}' order by fname")
  end

  def full_name
    "#{fname}&nbsp;#{lname}"
  end

  def show_name
    "#{fname} #{lname}"
  end

  def full_address
    "#{fname} #{lname}<#{email}>"
  end

  protected
    def check_fname_and_lname
        errors.add 'fname', t(:validate_fname_error) unless self.fname =~ /^.{2,20}$/i
        errors.add 'lname', t(:validate_lname_error) unless self.lname =~ /^.{2,20}$/i
    end

    def check_mail_cannot_be_changed
        # Contact e-mail cannot be changed
        unless self.new_record?
        old_record = Contact.find(self.id)
        errors.add 'email', t(:contact_cannot_be_changed) unless old_record.email == self.email
      end
    end

    def check_mail
        # Contact e-mail cannot be changed, so we only need to validate it on create
        errors.add 'email', t(:validate_email_error) unless valid_email?(self.email)
        # Already existing e-mail in contacts for this user is not allowed
        if self.new_record?
            if Contact.find :first, :conditions => {:email => email, :customer_id => customer_id}
                errors.add('email', I18n.t(:email_exists))
            end
        end
    end

end
