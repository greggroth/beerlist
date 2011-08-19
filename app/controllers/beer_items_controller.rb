class BeerItemsController < ApplicationController
helper_method :sort_column, :sort_direction
before_filter :authenticate, :except => [:index, :show]


# GET /beer_items/
# GET /beer_items.xml
def index
  @beer_items = BeerItem.order(sort_column + " " + sort_direction)
   # @beer_items = BeerItem.find(:all, :include => [:beer, :bar], :order => ('updated_at DESC'), :limit => 15)
   # @recent_beer_items = @beer_items.find(:all, :conditions => ["updated_at < ?", 1.week.ago])

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
	if BarPermission.where("user_id = ?", current_user.id).exists?
   		@beer_item = BeerItem.new
	else
		redirect_to beer_items_path
	end
end

# POST /beer_items
# POST /beer_items.xml
def create
   @beer_item = current_user.beer_items.new(params[:beer_item])
   respond_to do |format|
     if @beer_item.save
	format.html { redirect_to(beer_items_path, :notice => 'New listing added') }
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

	if not @beer_item.bar.has_permission?(current_user)
		redirect_to(beer_items_path)
	end
end

# PUT /beer_items/1
# PUT /beer_itmes/1.xml
def update
   # @beer_item = current_user.beer_items.find(params[:id])
	@beer_item = BeerItem.find(params[:id])
   
   respond_to do |format|
	if @beer_item.update_attributes(params[:beer_item]) && @beer_item.bar.has_permission?(current_user)
	  format.html { redirect_to(@beer_item, :notice => 'Entry was sucesfully updated') }
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
		redirect_to beer_items_path
	end

    respond_to do |format|
      format.html { redirect_to(beer_items_path) }
      format.xml { head :ok }
    end
end

private
def sort_column
  BeerItem.column_names.include?(params[:sort]) ? params[:sort] :"created_at"
end

def sort_direction
  %w[asc desc].include?(params[:direction]) ? params[:direction] :"asc"
end

end
