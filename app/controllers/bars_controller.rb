class BarsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_user!, :except => [:index, :show]
  
  cache_sweeper :bars_sweeper, :only => [:create, :update, :destroy]

  # GET /bars
  # GET /bars.xml
  def index
    if params[:search].present?
      @bars = Bar.search_tank(params[:search])
    else
      if iphone_request?
       @bars = Bar.includes(:beer_items).order("name ASC")
      else
       @bars = Bar.includes(:beer_items).page(params[:page]).per(25)
      end
    end
    
    if user_signed_in?
      # @user_followings = BarFollowing.where(user_id: current_user.id).includes(:bar => [ :beers ])
		  @user_bars = BarFollowing.where(user_id: current_user.id).includes(:bar => [ :beer_items ]).map { |follow| follow.bar }
		else
      # @user_followings = []
		  @user_bars = []
    end
  end

  def show
    @bar = Bar.find(params[:id])

    @beer_items = BeerItem.where("bar_id = ?", params[:id]).includes({ :beer => [:ratings, :brewery] }).order("beers.name ASC")
    
    # case params[:sort]
    # when nil
    #   if params[:sort_by_pouring].nil? || params[:sort_by_pouring]=='all' # NIL NIL
    #     @beer_items = @bar.beer_items.includes({ :beer => [:ratings, :brewery] }).order("beers.name ASC")
    #   else                              # NIL !NIL
    #     @beer_items = @bar.beer_items.find(:all, :include => [{ :beer => [:ratings, :brewery] }], :conditions => ["pouring = ?", params[:sort_by_pouring]], :order => "beers.name ASC")
    #   end
    # when 'abd'  # sorting will reset pouring type select
    #   hold = @bar.beer_items.find(:all, :include => [{ :beer => [:ratings, :brewery] }])
    #    if params[:direction] == "asc"
    #      @beer_items = hold.sort_by { |e| e.abd }
    #    else  #desc
    #      @beer_items = hold.sort_by { |e| -e.abd }
    #    end
    # else        #  normal sorting
    #   @beer_items = @bar.beer_items.find(:all, :include => [{ :beer => [:ratings, :brewery] }], :order => [sort_column + " " + sort_direction])
    # end
  
    # @recent_beer_items = @beer_items.select { |i| i.created_at > 1.week.ago }
    # @specials = @beer_items.select { |i| (0..6).member?(i.weekday) }.group_by { |i| i.weekday }
    # @beer_items.delete_if { |i| (0..6).include? i.weekday }
  	  	
    if @bar.latitude.present? && @bar.longitude.present?
      @gmaps_json = @bar.to_gmaps4rails
    end
  
  end

  def new
    @bar = Bar.new
  end

  def edit
    @bar = Bar.find(params[:id])
  end


  def create
    @bar = Bar.new(params[:bar])

    respond_to do |format|
      if @bar.save
        format.html { redirect_to(bars_path, :notice => "Bar was successfully created. (#{undo_link})") }
        format.iphone { redirect_to(bars_path, :notice => 'Bar was successfully created.') }
        format.xml  { render :xml => @bar, :status => :created, :location => @bar }
      else
        format.html { render :action => "new" }
        format.iphone { render :action => "new" }
        format.xml  { render :xml => @bar.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @bar = Bar.find(params[:id])

    respond_to do |format|
      if @bar.update_attributes(params[:bar])
        format.html { redirect_to(@bar, :notice => "Bar was successfully updated. (#{undo_link})") }
        format.iphone { redirect_to(@bar, :notice => 'Bar was successfully updated.') }
      else
        format.html { render :action => "edit", :notice => 'Unable to edit' }
        format.iphone { render :action => "edit", :notice => 'Unable to edit' }
      end
    end
  end

  def destroy
    @bar = Bar.find(params[:id])
    
    if current_user.has_permission?(@bar.id)
      @bar.destroy
    else
      redirect_to @bar, :notice => "You do not have permission to remove this bar"
    end

    respond_to do |format|
      format.html { redirect_to bars_path }
      format.xml  { head :ok }
    end
  end	

  def follow
    @bar_following = current_user.BarFollowing.new(:bar_id=>@bar.id)
	  if user_signed_in?
		  @user_bars = current_user.bars.find(:all)
		  logger.debug @user_bars
	  end
	  
	  render :action => "index"
  end
  
private
  def sort_column
    if (params[:sort] == "beers.name") || (params[:sort] == "beers.abv") || (params[:sort] == "abd")
      return params[:sort]
    else
      BeerItem.column_names.include?(params[:sort]) ? params[:sort] :"created_at"
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] :"desc"
  end
  
  def undo_link
    view_context.link_to("undo", revert_version_path(@bar.versions.scoped.last), :id => "undo_button", :method => :post)
  end

end
