module ApplicationHelper
  # Creates a submit button with the given name with a cancel link
  # Accepts two arguments: Form object and the cancel link name
  
  def submit_or_cancel(form, button_name = 'Submit', link_name='Cancel')
    form.submit(button_name) + " or " + link_to(link_name, 'javascript:history.go(-1);', :class => 'cancel')
  end
  
  # Request from an iPhone or iPod touch? (Mobile Safari user agent)
	def iphone_user_agent?
	  request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
	end
	
	def sortable(column, title=nil)
	  title ||= column.titleize
	  css_class = column == sort_column ? "current #{sort_direction}" : nil
	  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	  link_to title, {:sort => column, :direction => direction}, {:class => css_class}
	end
end
