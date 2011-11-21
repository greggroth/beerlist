class UsersSweeper < ActionController::Caching::Sweeper
  observe User
  
  def after_save(user)
     expire_cache(user)
  end

  def after_destroy(user)
    expire_cache(user)
  end

  private
    def expire_cache(user)
      expire_fragment 'user_stats'
    end
end