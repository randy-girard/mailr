class InternalController < ApplicationController

	theme :theme_resolver
	layout "simple"

	def error
		@title = params[:title] || t(:general_error)
		@error = params[:error] || t(:unspecified_error)
		logger.error "!!! InternalControllerError: " + @error
	end

	def imaperror
		@title = t(:imap_error)
		@error = params[:error] || t(:unspecified_error)
		logger.error "!!! InternalControllerImapError: " + @error
        render 'error'
	end

	def loginfailure
        reset_session
        flash[:error] = t(:login_failure)
        @current_user = nil
        redirect_to :controller=>'user', :action => 'login'
	end

end
