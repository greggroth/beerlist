class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def show
    flash[:notice] = "HError?"
    
    if same_user?
      @user = User.includes(:beer_items, :bars, { :had_beers => [:beer_style, :brewery, :beer_items] }).find(params[:id])
      
      respond_to do |format|
        format.html
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, :notice => "You can only view your own profile" }
      end
    end
  end

private
  def same_user?
    current_user == User.find(params[:id])
  end
 
end
