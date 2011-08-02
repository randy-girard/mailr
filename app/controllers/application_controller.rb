require 'yaml'

class ApplicationController < ActionController::Base

    #unless config.consider_all_requests_local
    #    #rescue_from ActionController::RoutingError, :with => :route_not_found
    #    rescue_from ActiveRecord::RecordNotFound, :with => :route_not_found
    #end

	protect_from_forgery
	before_filter :load_defaults,:set_locale,:current_user

    ################################# protected section ###########################################

	protected

	def load_defaults
		$defaults ||= YAML::load(File.open(Rails.root.join('config','defaults.yml')))
	end

	def theme_resolver
		if @current_user.nil?
			$defaults['theme']
		else
			@current_user.prefs.theme || $defaults['theme']
		end
	end

	def set_locale
		if @current_user.nil?
			I18n.locale = $defaults['locale'] || I18n.default_locale
		else
			I18n.locale = @current_user.prefs.locale || I18n.default_locale
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

	def selected_folder
        session[:selected_folder] ? @selected_folder = session[:selected_folder] : @selected_folder = $defaults['mailbox_inbox']
	end

	def get_current_folders
		@folders_shown = @current_user.folders.shown.order("name asc")
		@current_folder = @current_user.folders.current(@selected_folder)
	end

    ##################################### private section ##########################################

    #private

    #def route_not_found
    #    render :text => 'What the fuck are you looking for ?', :status => :not_found
    #end

end
