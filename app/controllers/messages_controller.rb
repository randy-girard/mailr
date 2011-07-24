require 'imap_utils'

class MessagesController < ApplicationController

	include ImapUtils

	before_filter :check_current_user, :info
	theme :theme_resolver

	def index
		logger.info "YYYYYYYYYYYYY #{@m.inspect}"
	end

end
