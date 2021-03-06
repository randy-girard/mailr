require_dependency 'maildropserializator'
class Customer < ActiveRecord::Base
  include MaildropSerializator
  
  has_many :filters, :order => "order_num"
  has_one :mail_pref
  attr_accessor :password
  attr_accessible :email, :customer_id, :fname, :lname, :created_at, :updated_at
  
  def mail_temporary_path
    "#{Mailr::CONFIG[:mail_temp_path]}/#{self.email}"
  end
  
  def friendlly_local_email
    encode_email("#{self.fname} #{self.lname}", check_for_domain(email))
  end
  
  def mail_filter_path
    "#{Mailr::CONFIG[:mail_filters_path]}/#{self.email}"
  end

  def local_email
    self.email
  end
  
  def check_for_domain(email)
    if email && !email.nil? && !email.include?("@") && Mailr::CONFIG[:send_from_domain]
      email + "@" + Mailr::CONFIG[:send_from_domain]
    else
      email
    end
  end
end
