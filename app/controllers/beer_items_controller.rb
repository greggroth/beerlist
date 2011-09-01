class BeerItemsController < ApplicationController
helper_method :sort_column, :sort_direction
before_filter :authenticate, :except => [:index, :show]


# GET /beer_items/
# GET /beer_items.xml
def index
   @beer_items = BeerItem.find(:all, :include => [:beer,:bar], :order => [sort_column + " " + sort_direction])
   respond_to do |format|
	  format.html
      # format.iphone { render :layout => false }
  	format.xml { render :xml => @beer_items }
   end
end

# GET /beer_items/1
# GET /beer_items/1.xml
def show
   @beer_item = BeerItem.find(params[:id])

  respond_to do |format|
	  format.html
  	format.xml { render :xml => @beer_item }
  end
end

# GET /beer_items/new
# GET /beer_items/new.xml
def new
  @beer_item = BeerItem.new
  
  respond_to do |format|
	  format.html
  	format.xml { render :xml => @beer_item }
  end
   
  # if BarPermission.where("user_id = ?", current_user.id).exists?
  #       @beer_item = BeerItem.new
  # else
  #   redirect_to beer_items_path, :notice => 'You do not have permission to create a listing'
  # end
end

# POST /beer_items
# POST /beer_items.xml
def create
   @beer_item = current_user.beer_items.new(params[:beer_item])
   
   respond_to do |format|
     if @beer_item.save
	    format.html { redirect_to(beer_items_path, :notice => "Beer listing added #{undo_link}") }
    	format.xml { render :xml => @beer_item, :status => :created, :location => @beer_item }
     else
	    format.html { render :action => "new" }
    	format.xml { render :xml => @beer_item.errors, :status => :unprocessable_entity }
     end
   end
end

# GET /beer_items/1/edit
def edit
   # @beer_item = current_user.beer_items.find(params[:id])
	@beer_item = BeerItem.find(params[:id])

  # unless @beer_item.bar.has_permission?(current_user)
  #   redirect_to(beer_items_path)
  # end
end

# PUT /beer_items/1
# PUT /beer_itmes/1.xml
def update
   # @beer_item = current_user.beer_items.find(params[:id])
	@beer_item = BeerItem.find(params[:id])
   
   respond_to do |format|
	if @beer_item.update_attributes(params[:beer_item])
	  format.html { redirect_to(@beer_item, :notice => "Beer listing updated #{undo_link}") }
	  format.xml { head :ok }
	else
	  format.html { render :action => "edit" }
	  format.xml { render :xml => @article.errors, :status => :unprocessable_entry }
	end
   end
end

def destroy
   # @beer_item = current_user.beer_items.find(params[:id])
	@beer_item = BeerItem.find(params[:id])
	if @beer_item.bar.has_permission?(current_user)
    		@beer_item.destroy
	else
		redirect_to beer_items_path, :notice => "Beer listing removed #{undo_link}"
	end

    respond_to do |format|
      format.html { redirect_to(beer_items_path) }
      format.xml { head :ok }
    end
end

private
  def sort_column
    if (params[:sort] == "beers.name") || (params[:sort] == "bars.name") 
      return params[:sort]
    else
      BeerItem.column_names.include?(params[:sort]) ? params[:sort] :"created_at"
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] :"asc"
  end

  def undo_link
    view_context.button_to("undo", revert_version_path(@beer_item.versions.scoped.last), :method => :post )
  end

end
