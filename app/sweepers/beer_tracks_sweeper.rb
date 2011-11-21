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
      expire_fragment 'user_stats'
    end
end