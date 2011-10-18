class BeerTracksController < ApplicationController
  helper_method :sort_column, :sort_direction
    
  def create
    current_user.drinks_it(params[:beer_track])
    
    @bar = Bar.find(params[:beer_track][:bar_id])          
    @beer_item = BeerItem.find(:all, :conditions => ["beer_id = ? AND bar_id = ?", params[:beer_track][:beer_id], params[:beer_track][:bar_id]]).first
    
    respond_to do |format|
  		format.html { redirect_to bar_path(@bar) }
  		format.js
  	end
  end

  def destroy
    bt = BeerTrack.find(params[:id])
    bt.destroy
    
    respond_to do |format|
  		format.html { redirect_to bar_path(@bar) }
  		format.js
  	end
  end
  
  
private
  def sort_column
    if (params[:sort] == "beers.name") || (params[:sort] == "beers.abv") || (params[:sort] == "abd")
      return params[:sort]
    else
      BeerItem.column_names.include?(params[:sort]) ? params[:sort] :"created_at"
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] :"desc"
  end
  
end
