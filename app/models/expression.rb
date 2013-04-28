class Expression < ActiveRecord::Base
  attr_accessible :operator, :case_sensitive, :expr_value, :field_name
end
