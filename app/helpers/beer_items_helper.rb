module BeerItemsHelper
  def iphone_request?
		return (request.subdomains.first == "iphone" || params[:format] == "iphone")
	end
  	
  def pouring(item)
    if item.pouring == "bucket"
      "bucket of #{item.bucket_of} (#{number_to_human(item.volume, :units => {:unit => item.volunit})} each)"
    else
      "#{number_to_human(item.volume, :units => {:unit => item.volunit})} #{item.pouring}"
    end
  end
end
