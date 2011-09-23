class BarsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /bars
  # GET /bars.xml
  def index
    
    ##  There has to be a better way!
    if params[:search].present?
      if params[:zip].present?
        @bars = Bar.near(params[:zip], 50, :order => :distance).search_tank(params[:search])
      else
        @bars = Bar.search_tank(params[:search])
      end
    else
      if params[:zip].present?
        @bars = Bar.near(params[:zip], 50, :order => :distance).page(params[:page]).per(50)
      else
        # @bars = Bar.order("name ASC").
        if iphone_request?
          @bars = Bar.includes(:beers).order("name ASC")
        else
          @bars = Bar.page(params[:page]).per(25)
        end
      end
    end
    
    if user_signed_in?
		  @user_bars = current_user.bars.find(:all)
	  end
	  
	  respond_to do |format|
	    format.js
	    format.html
	    format.iphone { render :layout => false }
	  end
  end

  # GET /bars/1
  # GET /bars/1.xml
  def show
  @bar = Bar.find(params[:id])
  
	# @beer_items = BeerItem.alphabetical.where("bar_id = ?", params[:id])
	
  # if params[:sort].nil?
  #   unless params[:search_by_pouring].nil?
  #     @beer_items = Bar.find(:all, :include => [:beer,:beer_items], :conditions => ["pouring = ?", params[:search_by_pouring]], :order => "price ASC")
  #     else
  #       @beer_items = BeerItem.find(:all, :include => [:bar, :beer], :conditions => ["bar_id = ?", params[:id]], :order => "price ASC" )
  #     end
  #   else
  #     if params[:sort] == "abd" && params[:search_by_pouring].nil?  # have to sort using a different method
  #       hold = BeerItem.find(:all, :include => [:bar, :beer], :conditions => ["bar_id = ?", params[:id]])
  #       if params[:direction] == "asc"
  #         @beer_items = hold.sort_by { |e| e.abd }
  #       else  #desc
  #         @beer_items = hold.sort_by { |e| -e.abd }
  #       end
  #     else
  #       @beer_items = BeerItem.find(:all, :include => [:bar, :beer], :conditions => ["bar_id = ?", params[:id]], :order => [sort_column + " " + sort_direction] )
  #     end
  #   end
  
  case params[:sort]
  when nil
    if params[:sort_by_pouring].nil? || params[:sort_by_pouring]=='all' # NIL NIL
      logger.debug "Nil Nil"
      @beer_items = BeerItem.find(:all, :include => [:bar, :beer], :conditions => ["bar_id = ?", params[:id]], :order => "price ASC" )
    else                              # NIL !NIL
      logger.debug "Nil !Nil"
      @beer_items = BeerItem.find(:all, :include => [:beer,:bar], :conditions => ["pouring = ? AND bar_id = ?", params[:sort_by_pouring], params[:id]], :order => "price ASC")
    end
  when 'abd'  # sorting will reset pouring type select
    hold = BeerItem.find(:all, :include => [:bar, :beer], :conditions => ["bar_id = ?", params[:id]])
     if params[:direction] == "asc"
       @beer_items = hold.sort_by { |e| e.abd }
     else  #desc
       @beer_items = hold.sort_by { |e| -e.abd }
     end
  else        #  normal sorting
    @beer_items = BeerItem.find(:all, :include => [:beer,:bar], :conditions => ["bar_id = ?", params[:id]], :order => [sort_column + " " + sort_direction])
  end
  
	
	@recent_beer_items = BeerItem.alphabetical.find(:all, :conditions => ["bar_id = ? AND beer_items.updated_at > ?", params[:id], 1.week.ago])
	if @bar.latitude.present? && @bar.longitude.present?
		@json = @bar.to_gmaps4rails
	end
	
	respond_to do |format|
    format.html
    format.iphone { render :layout => false }
  end
	
  end

  # GET /bars/new
  # GET /bars/new.xml
  def new
    @bar = Bar.new
  end

  # GET /bars/1/edit
  def edit
    @bar = Bar.find(params[:id])

  # unless @bar.has_permission?(current_user)
  #   redirect_to(@bar)
  # end
  end

  # POST /bars
  # POST /bars.xml
  def create
    @bar = Bar.new(params[:bar])

    respond_to do |format|
      if @bar.save
        format.html { redirect_to(bars_path, :notice => 'Bar was successfully created.') }
        format.xml  { render :xml => @bar, :status => :created, :location => @bar }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bars/1
  # PUT /bars/1.xml
  def update
    @bar = Bar.find(params[:id])

    respond_to do |format|
      if @bar.update_attributes(params[:bar])
        format.html { redirect_to(@bar, :notice => 'Bar was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :notice => 'Unable to edit' }
        format.xml  { render :xml => @bar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bars/1
  # DELETE /bars/1.xml
  def destroy
    @bar = Bar.find(params[:id])
    
    if current_user.has_permission?(@bar.id)
      @bar.destroy
    else
      redirect_to @bar, :notice => "You do not have permission to remove this bar"
    end

    respond_to do |format|
      format.html { redurect_to bars_path }
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

end
