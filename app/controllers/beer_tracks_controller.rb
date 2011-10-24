class BeerTracksController < ApplicationController
  def create
    current_user.drinks_it(params[:beer_track])
    
    case params[:from]
    when "bars_page"
      @from = "bars_page"
      @beer_item = BeerItem.find(params[:beer_item_id], :include => [{:beer => :ratings}])
    when "beers_page"
      @from = "beers_page"
      @beer = Beer.find(params[:beer_track][:beer_id])
    when "beers_index"
      @from = "beers_index"
      @beer = Beer.find(params[:beer_track][:beer_id])
    end
  end

  def destroy
    bt = BeerTrack.find(params[:id])
    bt.destroy
    
    case params[:from]
    when "bars_page"
      @from = "bars_page"
      @beer_item = BeerItem.find(params[:beer_item_id])
    when "beers_index"
      @from = "beers_index"
      @beer = bt.beer
    end
  end
end
