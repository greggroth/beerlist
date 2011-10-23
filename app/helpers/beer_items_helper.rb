module BeerItemsHelper
	  def iphone_request?
  		return (request.subdomains.first == "iphone" || params[:format] == "iphone")
  	end
end
