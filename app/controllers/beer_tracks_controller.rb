class BeerTracksController < ApplicationController

  def index
    @user_beers = user_signed_in? ? current_user.had_beers.map { |i| i.id } : []
    
    respond_to do |format|
     format.json { render json: @user_beers }
    end
  end
  
  def create
    puts "BEER TRACK CREATE ACTION CALLED"

    if current_user.has_drunk?(Beer.find(params[:beer_track][:beer_id]))
      puts "REMOVED IT"
      current_user.didnt_drink(params[:beer_track][:beer_id])
    else
      puts "ADDED IT"
      current_user.drinks_it(params[:beer_track])
    end
    #     
    #     case params[:from]
    #     when "bars_page"
    #       @from = "bars_page"
    #       @beer_item = BeerItem.find(params[:beer_item_id], :include => [{:beer => :ratings}])
    #     when "beers_page"
    #       @from = "beers_page"
    #       @beer = Beer.find(params[:beer_track][:beer_id])
    #     when "beers_index"
    #       @from = "beers_index"
    #       @beer = Beer.find(params[:beer_track][:beer_id])
    #     end
    #     
    #     # @had_beers = current_user.had_beers if user_signed_in?
    #     @user_beers = current_user.had_beers if user_signed_in?
    # @beer_tracks = current_user.beer_tracks if user_signed_in?
  end

  def destroy
    puts "DESTROY THE BEER TRACK"
    # bt = BeerTrack.find(params[:id])
    #     bt.destroy
    #     
    #     case params[:from]
    #     when "bars_page"
    #       @from = "bars_page"
    #       @beer_item = BeerItem.find(params[:beer_item_id])
    #     when "beers_index"
    #       @from = "beers_index"
    #       @beer = bt.beer
    #     end
    #     
    #     # @had_beers = current_user.had_beers if user_signed_in?
    #     @user_beers = current_user.had_beers if user_signed_in?
    #     @beer_tracks = current_user.beer_tracks if user_signed_in?
  end
end
