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
    
    @had_beers = current_user.had_beers if user_signed_in?
  	@beer_tracks = current_user.beer_tracks if user_signed_in?
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
    
    @had_beers = current_user.had_beers if user_signed_in?
  	@beer_tracks = current_user.beer_tracks if user_signed_in?
  end
end
