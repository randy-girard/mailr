class Filter < ActiveRecord::Base
  has_many :expressions
  attr_accessible :id, :destination_folder, :name
end
