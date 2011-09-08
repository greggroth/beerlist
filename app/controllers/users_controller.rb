class UsersController < ApplicationController

  # before_filter :authenticate, :only => [:edit, :update]  
  # 
  # def show
  #   user_signed_in? ? @user = current_user : redirect_to(root_path)
  # end
  # 
  # def new
  #   if signup_allowed?
  #     @user = User.new
  #   else
  #     redirect_to root_path, :notice => 'Beta signups limit reached.'
  #   end
  # end
  # 
  # def create
  #   @user = User.new(params[:user])
  #   if @user.save
  #     session[:user_id] = @user.id
  #     redirect_to root_path, :notice => 'New user successfully added.'
  #   else
  #     render :action => 'new'
  #   end
  # end
  # 
  # def edit
  #   @user = current_user
  # end
  # 
  # def update
  #   @user = current_user
  #   if @user.update_attributes(params[:user])
  #     redirect_to root_path, :notice => 'Updated user information successfully.'
  #   else
  #     render :action => 'edit'
  #   end
  # end
end
