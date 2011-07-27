class Server < ActiveRecord::Base

	validates_presence_of :name
	belongs_to :user
	before_save :fill_params

	def self.primary
		first
	end

	private

	def fill_params
        self.port = $defaults['imap_port']
        $defaults['imap_use_ssl'] == true ? self.use_ssl = 1 : self.use_ssl = 0
	end

end
