class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  def show
    if same_user?
      @user = current_user

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
    logger.debug "fdkfsjldfj"
    current_user == User.find(params[:id])
  end
 
end
