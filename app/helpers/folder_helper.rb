module FolderHelper

    def folder_link(folder)
        folder.parent.empty? ? name = folder.name : name = folder.parent.gsub(/\./,'#') + "#" + folder.name
        s = link_to folder.name.capitalize, :controller => 'messages', :action => 'folder', :id => name
        if !folder.unseen.zero?
            s += ' (' + folder.unseen.to_s + ')'
        end
        s
    end

    def pretty_folder_name(folder)
        folder.nil? ? t(:no_folder_selected) : folder.name.capitalize
    end

    def select_for_folders(name,id,object,label,blank)
        html = ""
        html << "<div class=\"group\">"
        html << "<label class=\"label\">#{label}</label>"
        html << select(name, id, object.all.collect {|p| [ p.parent.empty? ? p.name : p.parent+p.delim+p.name, p.id ] }, { :include_blank => (blank == true ? true : false)})
        html << "</div>"
    end

end
