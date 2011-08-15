class BarOwnerController < ApplicationController

  # GET /bar_owner
  # GET /bar_owner.xml
  def index
  
    respond_to do |format|
      format.html # index.slim
      format.xml  { render :xml => @bars }
    end
  end
  
  def show
  	if logged_in? && current_user.is_a_bar_admin?
  		@bars = current_user.admin_bars
  		
  		respond_to do |format|
		  format.html # show.slim
		  format.xml  { render :xml => @bars }
		end
  	else
  		redirect_to root_path, :notice => 'Entry was sucesfully updated'
  	end
  end

end
