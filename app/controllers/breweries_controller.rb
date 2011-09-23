class BreweriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /breweries
  # GET /breweries.xml
  def index
    if params[:search].present?
      @breweries = Brewery.includes(:beers).search_tank(params[:search])
    else
      @breweries = Brewery.includes(:beers).order("name ASC").page(params[:page]).per(25)
    end
    
    respond_to do |format|
      format.js
 	    format.html
 	    format.iphone { render :layout => false }
 	  end
  end

  # GET /breweries/1
  # GET /breweries/1.xml
  def show
    @brewery = Brewery.find(params[:id])
	  @beers = @brewery.beers.all
	# @beer_items = BeerItem.where("brewery_id = ?", params[:id])
    # @bar_count = @beers.count('bars', :distict => true)

	  respond_to do |format|
	    format.html
	    format.iphone { render :layout => false }
	  end

  end

  # GET /breweries/new
  # GET /breweries/new.xml
  def new
    @brewery = Brewery.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @brewery }
    end
  end

  # GET /breweries/1/edit
  def edit
    @brewery = Brewery.find(params[:id])
  end

  # POST /breweries
  # POST /breweries.xml
  def create
    @brewery = Brewery.new(params[:brewery])

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to(breweries_path, :notice => 'Brewery was successfully created.') }
        format.xml  { render :xml => @brewery, :status => :created, :location => @brewery }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @brewery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /breweries/1
  # PUT /breweries/1.xml
  def update
    @brewery = Brewery.find(params[:id])

    respond_to do |format|
      if @brewery.update_attributes(params[:brewery])
        format.html { redirect_to(@brewery, :notice => 'Brewery was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @brewery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.xml
  def destroy
    @brewery = Brewery.find(params[:id])
    @brewery.destroy

    respond_to do |format|
      format.html { redirect_to(breweries_url) }
      format.xml  { head :ok }
    end
  end

  def beer_items(beerid)
	  BeerItem.where("beer_id = ?", beerid)
  end

end
