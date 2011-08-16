class PrefsController < ApplicationController

    before_filter :check_current_user,:selected_folder

	before_filter :get_current_folders

	before_filter :get_prefs

    theme :theme_resolver

    def index
    end

    def update
        if params[:prefs]
            @prefs.update_attributes(params[:prefs])
        end
        redirect_to :action => 'index'
    end

    ############################################ private section #########################################

    def get_prefs
        @prefs = @current_user.prefs
    end
end
