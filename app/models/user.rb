class User < ActiveRecord::Base
	validates_presence_of :email, :on => :create
    validates_presence_of :first_name,:last_name
	validates_uniqueness_of :email
	has_many :servers, :dependent => :destroy
end
