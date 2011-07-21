module NavigationHelper
  def link_back_to_messages
    link_to("&#171;" << t(:back_to_message), :controller=>"webmail", :action=>"messages")
  end

  def link_send_mail
    link_to( t(:compose), :controller=>"webmail", :action=>"compose")
  end

  def link_mail_prefs
    link_to( t(:preferences), :controller=>"webmail", :action=>"prefs")
  end

  def link_mail_filters
    link_to( t(:filters), :controller=>"webmail", :action=>"filters")
  end

  def link_contacts
    link_to( t(:contacts), contacts_path)
  end

  def folder_manage_link(folder)
    if folder.name == CDF::CONFIG[:mail_trash] or folder.name == CDF::CONFIG[:mail_inbox] or folder.name == CDF::CONFIG[:mail_sent]
      short_fn(folder)
    else
      short_fn(folder) + '&nbsp;' + link_to(t(:delete), folder_path(folder.name), :method => :delete)
    end
  end

  def link_import_preview() "/contacts/import_preview" end
  def link_main_index() root_url end
  def link_contact_import() url_for(:controller => :contacts, :action => :import) end
  def link_contact_choose() url_for(:controller => :contacts, :action => :choose) end

  def link_contact_list
    link_to(t(:list), :controller => :contacts, :action => :index)
  end

  def link_contact_add_one
    link_to(t(:add_one_contact), new_contact_path)
  end

  def link_contact_add_multiple
    link_to(t(:add_multiple), :controller => :contacts, :action => "add_multiple")
  end

  def link_contact_group_list
    link_to(t(:groups), :controller => :contact_group, :action => :index)
  end

  def link_folders
    link_to( t(:folders), :controller=>:webmail, :action=>:messages)
  end

  private

  def short_fn(folder)
    if folder.name.include? folder.delim
       folder.name.split(folder.delim).last
    else
      folder.name
    end
  end

  def main_navigation(active)
    s = ""
    s += "<ul class=\"wat-cf\">"
    active == :folders ? s += "<li class=\"first active\">#{link_folders}</li>" : s += "<li class=\"first\">#{links_folders}</li>"
    active == :compose ? s += "<li class=\"active\">#{link_send_mail}</li>" : s += "<li>#{link_send_mail}</li>"
    active == :prefs ? s += "<li class=\"active\">#{link_mail_prefs}</li>" : s += "<li>#{link_mail_prefs}</li>"
    active == :filters ? s += "<li class=\"active\">#{link_mail_filters}</li>" : s += "<li>#{link_mail_filters}</li>"
    active == :contacts ? s += "<li class=\"active\">#{link_contacts}</li>" : s += "<li>#{link_contacts}</li>"
    s += "</ul>"
  end
end
