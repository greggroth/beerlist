class RatingsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @beer = Beer.find(params[:beer_id])
    
    @rating = @beer.ratings.new(params[:rating])
    @rating.user_id = current_user.id
    @dimension = params[:rating][:dimension]
    
    if @rating.save
      respond_to do |format|
        format.html { redirect_to beer_path(@beer), :notice => "Rated!" }
        format.js
      end
    end
  end
  
  def update
    @beer = Beer.find(params[:beer_id])
    @dimension = params[:rating][:dimension]
    
    @rating = @beer.ratings.where(["user_id = ? AND dimension = ?", current_user.id, @dimension]).first

    
    logger.debug(params[:rating])
    if @rating.update_attributes(params[:rating])
      respond_to do |format|
        format.html { redirect_to beer_path(@beer), :notice => "Rated!" }
        format.js
      end
    end
  end

end
