class ContactsController < ApplicationController

	before_filter :check_current_user,:selected_folder

	before_filter :get_current_folders, :only => [:index]

	theme :theme_resolver

    def index
		flash[:notice] = 'Not implemented yet'
    end

end
