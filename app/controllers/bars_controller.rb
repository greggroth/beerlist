class BarsController < ApplicationController
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
        @bars = Bar.order("name ASC").page(params[:page]).per(25)
      end
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
    if (params[:sort] == "beers.name") || (params[:sort] == "bars.name") 
      return params[:sort]
    else
      BeerItem.column_names.include?(params[:sort]) ? params[:sort] :"created_at"
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] :"desc"
  end

end
