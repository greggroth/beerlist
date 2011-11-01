class BreweriesSweeper < ActionController::Caching::Sweeper
  observe Brewery

  def after_save(brewery)
    expire_cache(brewery)
  end

  def after_destroy(brewery)
    expire_cache(brewery)
  end

  private

    def expire_cache(brewery)
      expire_fragment 'list_of_breweries'
    end

end