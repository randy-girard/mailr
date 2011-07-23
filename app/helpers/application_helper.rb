module ApplicationHelper

def form_field(object,field,flabel,example)

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
	value = object.instance_eval(field) || ""
	html << value
	html << "\"/>"
	html << "<span class=\"description\">"
	html << t(:example)
	html << ": "
	html << example
	html << "</span>"
	html << "</div>"

end

def form_button(text)
	html = ""
	html << "<div class=\"group navform wat-cf\">"
	html << "<button class=\"button\" type=\"submit\">"
	html << "<img src=\""
	html << current_theme_image_path('tick.png')
	html << "\" alt=\""
	html << text
	html << "\" />"
	html << t(text.to_sym)
	html << "</button></div>"
end

end
