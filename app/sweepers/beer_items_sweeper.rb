class BeerItemsSweeper < ActionController::Caching::Sweeper
  observe BeerItem

  def after_save(beerItem)
    expire_cache(beerItem)
  end

  def after_destroy(beerItem)
    expire_cache(beerItem)
  end

  private

    def expire_cache(beerItem)
      expire_fragment 'todays_deals'
      expire_fragment 'top_deals'
      expire_fragment "list_of_beer_items_#{beerItem.bar.id}"
      expire_fragment 'page_header'
    end

end