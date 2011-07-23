require 'yaml'

class ApplicationController < ActionController::Base

	protect_from_forgery
	before_filter :load_defaults,:set_locale,:current_user

	protected

	def load_defaults
		@defaults = YAML::load(File.open(Rails.root.join('config','defaults.yml')))
	end

	def theme_resolver
		if @current_user.nil?
			@defaults['theme']
		else
			@current_user.theme
		end
	end

	def set_locale
		if @current_user.nil?
			I18n.locale = @defaults['locale'] || I18n.default_locale
		else
			I18n.locale = @current_user.locale || I18n.default_locale
		end
	end

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def check_current_user
		if @current_user.nil?
			session["return_to"] = request.fullpath
			redirect_to :controller=>"user", :action => "login"
			return false
		end
	end

end
