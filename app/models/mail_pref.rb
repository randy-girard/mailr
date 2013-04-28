# require_association 'customer'

class MailPref < ActiveRecord::Base
  belongs_to :customer
  
  attr_accessible :customer_id, :mail_type, :wm_rows, :id, :check_external_mail
  
    
#   def MailPref.find_by_customer(customer_id)
#     find :first, :conditions => (["customer_id = #{customer_id}"])
#   end
end
