module BeersHelper

  def rating_ballot(dim = :overall)
    @rating = @beer.ratings.where(["user_id = ? and dimension = ?", current_user.id, dim]).first
    unless @rating.nil?
      @rating
    else
      current_user.ratings.new :dimension => dim
    end
  end
  
  def current_user_rating(dim)
    @rating = @beer.ratings.where(["user_id = ? and dimension = ?", current_user.id, dim]).first
    unless @rating.nil?
        @rating.value
    else
        "N/A"
    end
  end

end
