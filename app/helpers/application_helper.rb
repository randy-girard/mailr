module ApplicationHelper

def form_field(object,field,flabel,example,val)

	html = ""
	html << "<div class=\"group\">"
	if object.errors[field.to_sym]
		html << "<div class=\"fieldWithErrors\">"

	end
	html << "<label class=\"label\">"
	if flabel.nil?
		html << t(field.to_sym)
	else
		html << t(flabel.to_sym)
	end
	html << "</label>"
	if object.errors[field.to_sym]
		html << "<span class=\"error\"> "
		html << object.errors[field.to_sym].to_s
		html << "</span>"
		html << "</div>"
	end
	html << "<input name=\""
	html << object.class.name.downcase+"_"+field
	html << "\" type=\"text\" class=\"text_field\" value=\""
	value = object.instance_eval(field) || val || ""
	html << value
	html << "\"/>"
	html << "<span class=\"description\">"
	html << t(:example)
	html << ": "
	html << example
	html << "</span>"
	html << "</div>"

end

def form_button(text,image)
	html = ""
	html << "<div class=\"group navform wat-cf\">"
	html << "<button class=\"button\" type=\"submit\">"
	html << "<img src=\""
	html << current_theme_image_path(image)
	html << "\" alt=\""
	html << text
	html << "\" />"
	html << t(text.to_sym)
	html << "</button></div>"
end

def form_button_value(text,image,onclick)
	html = ""
	html << "<div class=\"group navform wat-cf\">"
	html << "<button class=\"button\" type=\"submit\" onclick=\"window.location='"
	html << onclick
	html << "'\">"
	html << "<img src=\""
	html << current_theme_image_path(image)
	html << "\" alt=\""
	html << text
	html << "\" />"
	html << t(text.to_sym)
	html << "</button></div>"
end

def simple_input_field(name,label,value)
    html = ""
    html << "<div class=\"group\">"
    html << "<label class=\"label\">#{label}</label>"
    html << "<input name=\"#{name}\" class=\"text_field\" type=\"text\" value=\"#{value}\">"
    html << "</div>"
end

def select_field(name,object,label,blank)
    html = ""
    html << "<div class=\"group\">"
    html << "<label class=\"label\">#{label}</label>"
    html << select(name, name, object.all.collect {|p| [ p.name, p.id ] }, { :include_blank => (blank == true ? true : false)})
    html << "</div>"
end

#def form_simle_field(name,label,value)
#    html = ""
#    html << "<div class=\"group\">"
#    html << "<label class=\"label\">#{label}</label>"
#    html << "<input class=\"text_field\" type=\"text\" value=\"#{value}\">"
#    html << "</div>"
#end

def nav_to_folders
    link_to( t(:folders), :controller=>:folders, :action=>:index )
end

def nav_to_messages
    link_to( t(:messages), :controller=>:messages, :action=>:index )
end

def nav_to_compose
    link_to( t(:compose), :controller=>:messages, :action=>:compose )
end

def nav_to_contacts
    link_to( t(:contacts), :controller=>:contacts, :action=>:index )
end

def nav_to_prefs
    link_to( t(:preferences), :controller=>:prefs, :action=>:index )
end

def main_navigation(active)
    s = ""
    s += "<ul class=\"wat-cf\">"
    active == :messages ? s += "<li class=\"first active\">#{nav_to_messages}</li>" : s += "<li class=\"first\">#{nav_to_messages}</li>"
    active == :compose ? s += "<li class=\"active\">#{nav_to_compose}</li>" : s += "<li>#{nav_to_compose}</li>"
    active == :folders ? s += "<li class=\" active\">#{nav_to_folders}</li>" : s += "<li class=\"first\">#{nav_to_folders}</li>"
    active == :contacts ? s += "<li class=\"active\">#{nav_to_contacts}</li>" : s += "<li>#{nav_to_contacts}</li>"
    active == :prefs ? s += "<li class=\"active\">#{nav_to_prefs}</li>" : s += "<li>#{nav_to_prefs}</li>"
#    active == :filters ? s += "<li class=\"active\">#{link_mail_filters}</li>" : s += "<li>#{link_mail_filters}</li>"

    s += "</ul>"
end

def multi_select(id, name, objects, selected_objects, label, value,joiner,content = {})
  options = ""
  objects.each do |o|
    selected = selected_objects.include?(o) ? " selected=\"selected\"" : ""
    option_value = escape_once(o.send(value))
    text = [option_value]
    unless content[:text].nil?
      text = []
      content[:text].each do |t|
        text << o.send(t)
      end
      text = text.join(joiner)
    end
    text.gsub!(/^\./,'')
    bracket = []
    unless content[:bracket].nil?
      content[:bracket].each do |b|
        bracket << o.send(b)
      end
      bracket = bracket.join(joiner)
    end
    option_content = bracket.empty? ? "#{text}" : "#{text} (#{bracket})"
    options << "<option value=\"#{option_value}\"#{selected}>&nbsp;&nbsp;#{option_content}&nbsp;&nbsp;</option>\n"
  end
  "<div class=\"group\"><label class=\"label\">#{label}</label><select multiple=\"multiple\" size=10 id=\"#{id}\" name=\"#{name}\">\n#{options}</select></div>"
end


end
