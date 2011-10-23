module ApplicationHelper
  # Creates a submit button with the given name with a cancel link
  # Accepts two arguments: Form object and the cancel link name
  
  def submit_or_cancel(form, button_name = 'Submit', link_name='Cancel')
    form.submit(button_name) + " or " + link_to(link_name, 'javascript:history.go(-1);', :class => 'cancel')
  end
  
  # Request from an iPhone or iPod touch? (Mobile Safari user agent)
	def iphone_user_agent?
	  #  [/(Mobile\/.+Safari)/]
	  request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile)/]
	end
	
	def sortable(column, title=nil)
	  title ||= column.titleize
	  css_class = column == sort_column ? "current #{sort_direction}" : nil
	  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	  link_to title, {:sort => column, :direction => direction}, {:class => css_class}
	end
	
	def day_of_the_week(wday)
	  case wday
    when 0 then "Sunday"
    when 1 then "Monday"
    when 2 then "Tuesday"
    when 3 then "Wednesday"
    when 4 then "Thursday"
    when 5 then "Friday"
    when 6 then "Saturday"
    else "Everyday"
    end
	end
end
