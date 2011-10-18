class BeerTracksController < ApplicationController
  helper_method :sort_column, :sort_direction
    
  def create
    current_user.drinks_it(params[:beer_track])
      
    @beer_item = BeerItem.find(params[:beer_item_id])
  end

  def destroy
    bt = BeerTrack.find(params[:id])
    bt.destroy

    @beer_item = BeerItem.find(params[:beer_item_id])
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
