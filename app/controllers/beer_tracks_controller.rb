class BeerTracksController < ApplicationController
  def create
    current_user.drinks_it(params[:beer_track])
      
    @beer_item = BeerItem.find(params[:beer_item_id])
  end

  def destroy
    bt = BeerTrack.find(params[:id])
    bt.destroy

    @beer_item = BeerItem.find(params[:beer_item_id])
  end
end
