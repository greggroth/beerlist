class BeerTracksSweeper < ActionController::Caching::Sweeper
  observe BeerTrack

  def after_save(beer_track)
    expire_cache(beer_track)
  end

  def after_destroy(beer_track)
    expire_cache(beer_track)
  end

  private

    def expire_cache(beer_track)
      #  NEED TO EXPIRE THE BAR's BEER LIST
      # expire_fragment "list_of_beer_items_#{beerItem.bar.id}"
      expire_fragment 'page_header'
    end

end