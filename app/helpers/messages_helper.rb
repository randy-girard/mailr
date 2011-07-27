module MessagesHelper

    def folder_link(folder)
        folder.parent.empty? ? name = folder.name : name = folder.parent.gsub(/\./,'#') + "#" + folder.name
        s = link_to folder.name.capitalize, :controller => 'messages', :action => 'folder', :id => name
        if !folder.unseen.zero?
            s += ' (' + folder.unseen.to_s + ')'
        end
        s
    end

    def pretty_folder_name(folder)
        #folder = folder.gsub(/#/,".")
        folder.name.capitalize
    end

end

