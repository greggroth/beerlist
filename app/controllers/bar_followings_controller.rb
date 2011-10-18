class BarFollowingsController < ApplicationController

  def create
  	@bar = Bar.find(params[:bar_following][:bar_id])
  	current_user.follow!(@bar)
	
    if params[:search].present?
      @bars = Bar.near(params[:search], 50, :order => :distance)
    else
      @bars = Bar.find(:all, :order=>"name ASC")
    end
    
    if user_signed_in?
    @user_bars = current_user.bars.find(:all)
    end
  
  	respond_to do |format|
  		format.html	{ redirect_to bars_path }
  		format.js
  	end
  end

  def destroy
  	@bar_following = BarFollowing.find(params[:id])
  	current_user.unfollow!(@bar_following.bar)
	
    if params[:search].present?
      @bars = Bar.near(params[:search], 50, :order => :distance)
    else
      @bars = Bar.find(:all, :order=>"name ASC")
    end
    
    if user_signed_in?
    @user_bars = current_user.bars.find(:all)
    end
  
  	respond_to do |format|
  		format.html	{ redirect_to bars_path }
  		format.js
  	end
  end
end
