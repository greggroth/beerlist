class BeerItemsSweeper < ActionController::Caching::Sweeper
  observe BeerItem

  def after_save(beer_item)
    expire_cache(beer_item)
  end

  def after_destroy(beer_item)
    expire_cache(beer_item)
  end

  private

    def expire_cache(beer_item)
      expire_fragment 'todays_deals'
      expire_fragment 'top_deals'
      expire_fragment "list_of_beer_items_#{beer_item.bar.id}"
      expire_fragment 'page_header'
    end

end