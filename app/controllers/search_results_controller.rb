class SearchResultsController < ApplicationController

def index
  if params[:q].present?
    @results = Tanker.search([Bar, Beer, Brewery], params[:q], :per_page => 20)
  else
    redirect_to root_path
  end
end

end
