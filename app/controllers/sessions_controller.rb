class SessionsController < ApplicationController
 skip_filter :iphone_login_required
  
  def new 
  	respond_to do |format|
  		logger.debug "is doing the format thingy"
		format.html
		# format.iphone { render :format => false }
		format.xml { render :xml => @beer_items }
  	end
  end
  
  def create
    if user = User.authenticate(params[:email], params[:password])
      logger.debug "WAS AUTHENTICATED"
      session[:user_id] = user.id
      redirect_to root_path, :rel => "external", :notice => "Logged in successfully"
    else
    	logger.debug "WAS not AUTHENTICATED"
      flash.now[:alert] = "Invalid login/password combination"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    redirect_to beer_items_path #, :notice => "You successfully logged out"
  end

end
