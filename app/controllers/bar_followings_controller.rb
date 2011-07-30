class BarFollowingsController < ApplicationController

  def create
	@bar = Bar.find(params[:bar_following][:bar_id])
	current_user.follow!(@bar)
	
	respond_to do |format|
		format.html	{ redirect_to bars_path }
		format.js
	end
  end

  def destroy
	@bar_following = BarFollowing.find(params[:id])
	current_user.unfollow!(@bar_following.bar)
	respond_to do |format|
		format.html	{ redirect_to bars_path }
		format.js
	end
  end
end
