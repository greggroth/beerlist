class BarsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /bars
  # GET /bars.xml
  def index
    if params[:search].present?
    	@bars = Bar.near(params[:search], 50, :order => :distance)
    else
    	@bars = Bar.find(:all, :order=>"name ASC")
    end
    
    if user_signed_in?
		  @user_bars = current_user.bars.find(:all)
	  end
	
    respond_to do |format|
      format.html # index.html.erb
      format.iphone { render :layout => false }
      format.xml  { render :xml => @bars }
    end
  end

  # GET /bars/1
  # GET /bars/1.xml
  def show
  @bar = Bar.find(params[:id])
	@beer_items = BeerItem.alphabetical.where("bar_id = ?", params[:id])
	@recent_beer_items = BeerItem.alphabetical.find(:all, :conditions => ["bar_id = ? AND beer_items.updated_at > ?", params[:id], 1.week.ago])
	if @bar.latitude.present? && @bar.longitude.present?
		@json = @bar.to_gmaps4rails
	end
	
    respond_to do |format|
      format.html # show.html.erb
      format.iphone { render :layout => false }
      format.xml  { render :xml => @bar }
    end
  end

  # GET /bars/new
  # GET /bars/new.xml
  def new
    @bar = Bar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bar }
    end
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
        format.html { redirect_to(@bar, :notice => 'Bar was successfully created.') }
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

end
