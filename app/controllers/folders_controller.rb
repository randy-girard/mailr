class FoldersController < ApplicationController

    include ImapMailboxModule
	include ImapSessionModule

	before_filter :check_current_user ,:selected_folder

	before_filter :open_imap_session
	after_filter :close_imap_session

	before_filter :get_folders, :except => :manage

	theme :theme_resolver

    def index

    end

    def create
        if params["folder"].empty?
            flash[:warning] = t(:folder_to_create_empty)
            render "index"
        else
            begin
                if params["parent_folder"].empty?
                    @mailbox.create_folder(params[:folder])
                else
                    parent_folder = Folder.find(params["parent_folder"])
                    if parent_folder.depth >= $defaults["mailbox_max_parent_folder_depth"].to_i
                        raise Exception, t(:folder_max_depth)
                    end
                    @mailbox.create_folder(parent_folder.full_name + parent_folder.delim + params[:folder])
                end
            rescue Exception => e
                flash[:error] = t(:can_not_create_folder) + ' (' + e.to_s + ')'
                render 'index'
                return
            end
            redirect_to :action => 'manage', :flash => t(:folder_was_created), :type => :notice
        end
    end
    # FIXME if you delete folder you should change current folder because if you go to messages/index you got nil
    def delete
        if params["folder"].empty?
            flash[:warning] = t(:folder_to_delete_empty)
            render "index"
        else
            begin
                folder = Folder.find(params["folder"])
                system_folders = Array.new
                system_folders << $defaults["mailbox_inbox"]
                system_folders << $defaults["mailbox_trash"]
                system_folders << $defaults["mailbox_sent"]
                system_folders << $defaults["mailbox_drafts"]
                if system_folders.include?(folder.full_name.downcase)
                    raise Exception, t(:system_folder)
                end
                @mailbox.delete_folder(Folder.find(params["folder"]).full_name)
            rescue Exception => e
                flash[:error] = t(:can_not_delete_folder) + ' (' + e.to_s + ')'
                render 'index'
                return
            end
            redirect_to :action => 'manage', :flash => t(:folder_was_deleted), :type => :notice
        end
    end

    def sub_un_scribe
        redirect_to :action => 'manage'
    end

    def manage
        @current_user.folders.destroy_all
        folders=@mailbox.folders
        Folder.createBulk(@current_user,folders)
        if params[:flash]
            flash[params[:type]] = params[:flash]
        end
        redirect_to :action => 'index'
    end

    protected

    def get_folders
        @folders = @current_user.folders.order("name asc")
		@current_folder = @current_user.folders.current(@selected_folder)
    end

end
