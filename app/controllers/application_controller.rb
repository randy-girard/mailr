require 'yaml'

class ApplicationController < ActionController::Base

	protect_from_forgery

	before_filter :load_defaults
	before_filter :set_locale

	protected

	def load_defaults
		@defaults = YAML::load(File.open(Rails.root.join('config','defaults.yml')))
	end

	def theme_resolver
		@defaults['theme']
	end

	def set_locale
		I18n.locale = @defaults['locale'] || I18n.default_locale
	end

end
