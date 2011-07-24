class Prefs < ActiveRecord::Base

	validates_presence_of :theme,:locale

	has_one :user

	protected

	def self.create_default(user_id)
		Prefs.create(:user_id => user_id,
					 :theme => $defaults['theme'],
					 :locale => $defaults['locale'],
					 :msgs_per_page => $defaults['msgs_per_page'],
					 :msg_send_type => $defaults['msg_send_type']
					 )
	end
end
