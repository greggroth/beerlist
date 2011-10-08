class SearchResultsController < ApplicationController

def index
  unless params[:q].match(/[a-zA-Z0-9]/).nil?
    @results = Tanker.search([Bar, Beer, Brewery], params[:q], :per_page => 20)
  else
    redirect_to root_path, :alert => "Invalid Query"
  end
end

end
