class PrefsController < ApplicationController

    before_filter :check_current_user,:selected_folder

    theme :theme_resolver

    def index
        @folders = @current_user.folders.order("name asc")
        @current_folder = @current_user.folders.current(@selected_folder)
        flash[:notice] = 'Not implemented yet'
    end

end
