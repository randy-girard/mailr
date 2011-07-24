class MessagesController < ApplicationController

	before_filter :check_current_user
	theme :theme_resolver

	def index

	end

end
