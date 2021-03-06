class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :redirect_iphone_to_m
  before_filter :adjust_format_for_iphone
  before_filter :mailer_set_url_options

   
  
  private
    def mailer_set_url_options
      ActionMailer::Base.default_url_options[:host] = request.host_with_port
    end
  
  	def adjust_format_for_iphone
  		request.format = :iphone if iphone_request?
  	end
  	
  	def iphone_login_required
  		if iphone_request?
  		  redirect_to new_user_session_path unless user_logged_in?
  		end
  	end
  	
  	def redirect_iphone_to_m
  	  if request.subdomains.first == "iphone"
  	    redirect_to "http://m.atlbeerlist.com/", :status => 301
  	  end
	  end
	
	  def iphone_request?
	    logger.debug(request.subdomains.first)
  		return (request.subdomains.first == "m")
  	end

  protected
    # # Returns the currently logged in user or nil if there isn't one
    # def current_user
    #   return unless session[:user_id]
    #   @current_user ||= User.find_by_id(session[:user_id])
    # end
    # 
    # # Make current_user available in templates as a helper
    # helper_method :current_user

    # Filter method to enforce a login requirement
    # Apply as a before_filter on any controller you want to protect
    # def authenticate
    #   logged_in? ? true : access_denied
    # end
    # 
    # # Predicate method to test for a logged in user
    # def logged_in?
    #   current_user.is_a? User
    # end
    # 
    # # Make logged_in? available in templates as a helper
    # helper_method :logged_in?
    # 
    # def access_denied
    #   redirect_to new_user_session_path, :notice => "Please log in to continue" and return false
    # end

	# def follow(b_id, u_id)
	#	BarFollowing.create(:bar_id=>b_id, :user_id=>u_id)
	# end
	# 	helper_method :follow
  # 
  # def signup_allowed?
  #   return User.count <= 500
  # end
  # helper_method :signup_allowed?
	
	def self.responder
		MobileResponder
	end
end

class MobileResponder < ActionController::Responder

	def to_format
		super
	rescue ActiveView::MissingTemplate => e
		if request.format == "iphone"
			navigation_behavior(e)
		else
			raise unless resourceful?
			api_behavior(e)
		end
	end
end
