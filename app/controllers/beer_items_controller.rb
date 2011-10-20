class BeerItemsController < ApplicationController
helper_method :sort_column, :sort_direction
before_filter :authenticate_user!, :except => [:index, :show]


def index
  unless params[:search_by_pouring].nil?
    @best_deals = BeerItem.find(:all, :include => [:beer,:bar], :conditions => ["pouring = ?", params[:search_by_pouring]], :order => [sort_column + " " + sort_direction], :limit => 50)
  else
    # @beer_items = BeerItem.find(:all, :include => [:beer,:bar], :order => [sort_column + " " + sort_direction], :limit => 25)
    @best_deals = BeerItem.top_deals
  end
end


def show
   @beer_item = BeerItem.find(params[:id])
end


def new
  @beer_item = BeerItem.new(params[:beer_item])
end
   

def create
   @beer_item = current_user.beer_items.new(params[:beer_item])
   
   respond_to do |format|
     if @beer_item.save
	    format.html { redirect_to(beer_items_path, :notice => "Beer listing added #{undo_link}") }
	    format.iphone { redirect_to(@beer_item) }
    	format.xml { render :xml => @beer_item, :status => :created, :location => @beer_item }
     else
	    format.html { render :action => "new" }
	    format.iphone { render :action => "new" }
    	format.xml { render :xml => @beer_item.errors, :status => :unprocessable_entity }
     end
   end
end


def edit
	@beer_item = BeerItem.find(params[:id])
end


def update
	@beer_item = BeerItem.find(params[:id])
   
  respond_to do |format|
  	if @beer_item.update_attributes(params[:beer_item])
  	  format.html { redirect_to(@beer_item, :notice => "Beer listing updated #{undo_link}") }
  	  format.iphone { redirect_to(@beer_item) }
  	  format.xml { head :ok }
  	else
  	  format.html { render :action => "edit" }
  	  format.iphone { render :action => "edit" }
  	  format.xml { render :xml => @article.errors, :status => :unprocessable_entry }
  	end
  end
end

def destroy
	@beer_item = BeerItem.find(params[:id])
	@bar = @beer_item.bar

  @beer_item.destroy

  respond_to do |format|
    format.html { redirect_to(beer_items_path, :notice => "Beer listing removed #{undo_link}") }
    format.iphone { redirect_to(@bar) }
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
    %w[asc desc].include?(params[:direction]) ? params[:direction] :"desc"
  end

  def undo_link
    view_context.link_to("undo", revert_version_path(@beer_item.versions.scoped.last), :id => "undo_button", :method => :post)
  end

end
