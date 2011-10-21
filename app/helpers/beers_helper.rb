module BeersHelper

	def rating_ballot(beer, dim)
    @rating = beer.ratings.where(["user_id = ? and dimension = ?", current_user.id, dim]).first
    unless @rating.nil?
      @rating
    else
      beer.ratings.new :dimension => dim, :user_id => current_user.id
    end
  end
  
  def current_user_rating(beer, dim)
    @rating = beer.ratings.where(["user_id = ? and dimension = ?", current_user.id, dim]).first
    unless @rating.nil?
        @rating.value
    else
        "N/A"
    end
  end

end
