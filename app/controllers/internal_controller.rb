class InternalController < ApplicationController

	theme :theme_resolver
	layout "simple"

	def error
		@title = t(:general_error)
		@error = params[:error] || t(:unspecified_error)
		logger.error @error
	end

end
