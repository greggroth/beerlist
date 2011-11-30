class BarsSweeper < ActionController::Caching::Sweeper
  observe Bar

  def after_save(bar)
    expire_cache(bar)
  end

  def after_destroy(bar)
    expire_cache(bar)
  end

  private

    def expire_cache(bar)
      expire_fragment "bar_details_#{bar.id}"
    end

end