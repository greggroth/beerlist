class ProfilesController < ApplicationController

  def show
    if user_signed_in?
      @profile = Profile.find_by_user_id(current_user)
      @user_bars = current_user.bars
    else
      redirect_to(root_path)
    end
  end

  def new
    user_signed_in? ? @profile = Profile.new : redirect_to(root_path)
  end
  
  def edit
    if user_signed_in?
      @profile = Profile.find_by_user_id(current_user)
      if @profile.nil?
        @profile = Profile.new
        render(:action => 'new')
      end
    else 
      redirect_to(root_path)
    end
  end
  
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to(@profile, :notice => 'Profile created!') }
        format.xml  { render :xml => @beer, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    user_signed_in? ? @profile = Profile.find_by_user_id(current_user) : redirect_to(root_path)
    if @profile.update_attributes(params[:profile])
      redirect_to root_path, :notice => 'Profile updated.'
    else
      render :action => 'edit'
    end
  end

end
