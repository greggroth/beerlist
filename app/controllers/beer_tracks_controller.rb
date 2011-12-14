class BeerTracksController < ApplicationController

  def index
    @user_beers = user_signed_in? ? current_user.had_beers.map { |i| i.id } : []
    
    respond_to do |format|
     format.json { render json: @user_beers }
    end
  end

  # Acting more as a "Change" action
  def create
    if user_signed_in?
      # if current_user.has_drunk?(Beer.find(params[:beer_track][:beer_id]))
      if BeerTrack.where("user_id = ? AND beer_id = ?", current_user.id, params[:beer_track][:beer_id]).first.present?
        current_user.didnt_drink(params[:beer_track][:beer_id])
      else
        current_user.drinks_it(params[:beer_track])
      end
    end
    
    respond_to do |format|
      format.js
    end
  end
end
