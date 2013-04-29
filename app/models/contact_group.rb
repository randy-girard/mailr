class ContactGroup < ActiveRecord::Base
  has_and_belongs_to_many :contacts, :class_name => "Contact", :join_table => "contact_contact_groups", :association_foreign_key => "contact_id", :foreign_key => "contact_group_id"
  
  attr_accessible :name, :customer_id, :id, :created_at, :updated_at
  
  def ContactGroup.find_by_user(user_id)
    find_by_sql("select * from contact_groups where customer_id = #{user_id} order by name asc")
  end
  
  protected
    def validate
      errors.add('name', I18n.t(:validate_group_name_error)) unless self.fname =~ /^.{1,50}$/i
    end
    
    def validate_on_create
      if ContactGroup.find_first(["name = '#{name}' and customer_id = #{user_id}"])
        errors.add("name", _('Please enter group name (1 to 50 characters)'))
      end
    end
    
    def validate_on_update
      if ContactGroup.find_first(["name = '#{name}' and customer_id = #{user_id} and id <> #{id}"])
        errors.add("name", _('You already have contact group with this name'))
      end
    end
    
end
