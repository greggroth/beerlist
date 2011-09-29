class BeersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /beers
  # GET /beers.xml
  def index
    if params[:search].present?
      @beers = Beer.includes(:beer_style,:brewery).search_tank(params[:search])
    else
      if iphone_request?
        @beers = Beer.includes(:beer_style, :brewery).order('name ASC')
      else
        @beers = Beer.includes(:beer_style,:brewery).order('name ASC').page(params[:page]).per(25)
      end
    end
    
    logger.debug "Hello Index!"
    
    # respond_to do |format|
    #    format.js
    #       format.html
    #       format.iphone { render :layout => false }
    #     end
  end

  # GET /beers/1
  # GET /beers/1.xml
  def show
    @beer = Beer.find(params[:id])
  
    if params[:sort].nil?
      @beer_items = BeerItem.find(:all, :include => [:bar, :beer], :conditions => ["beer_id = ?",params[:id]], :order => "price ASC" )
    else
      if params[:sort] == "abd"   # have to sort using a different method
        hold = BeerItem.find(:all, :include => [:bar, :beer], :conditions => ["beer_id = ?",params[:id]])
        if params[:direction] == "asc"
          @beer_items = hold.sort_by { |e| e.abd }
        else  #desc
          @beer_items = hold.sort_by { |e| -e.abd }
        end
      else
        @beer_items = BeerItem.find(:all, :include => [:bar, :beer], :conditions => ["beer_id = ?",params[:id]], :order => [sort_column + " " + sort_direction] )
      end
    end
  
    # respond_to do |format|
    #   format.html
    #   format.iphone { render :layout => false }
    # end
  end

  # GET /beers/new
  # GET /beers/new.xml
  def new
    @beer = Beer.new
  end

  # GET /beers/1/edit
  def edit
    @beer = Beer.find(params[:id])
  end

  # POST /beers
  # POST /beers.xml
  def create
    @beer = Beer.new(params[:beer])

    respond_to do |format|
      if @beer.save
        format.html { redirect_to(beers_path, :notice => 'Beer was successfully created.') }
        format.iphone { redirect_to(beers_path) }
        format.xml  { render :xml => @beer, :status => :created, :location => @beer }
      else
        format.html { render :action => "new" }
        format.iphone { render :action => "new" }
        format.xml  { render :xml => @beer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /beers/1
  # PUT /beers/1.xml
  def update
    @beer = Beer.find(params[:id])

    respond_to do |format|
      if @beer.update_attributes(params[:beer])
        format.html { redirect_to(@beer, :notice => 'Beer was successfully updated.') }
        format.iphone { redirect_to(@beer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.iphone { render :action => "edit" }
        format.xml  { render :xml => @beer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.xml
  def destroy
    @beer = Beer.find(params[:id])
    @beer.destroy

    respond_to do |format|
      format.html { redirect_to(beers_url) }
      format.iphone { redirect_to(beers_url) }
      format.xml  { head :ok }
    end
  end

private
  def sort_column
    if (params[:sort] == "bars.name") || (params[:sort] == "abd")
      return params[:sort]
    else
      BeerItem.column_names.include?(params[:sort]) ? params[:sort] :"created_at"
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] :"desc"
  end

  def undo_link
    view_context.link_to("undo", revert_version_path(@beer_item.versions.scoped.last), :id => "undo_button", :method => :post)
  end
end
