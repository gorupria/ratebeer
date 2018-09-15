module RatingAverage

  def average_rating
    tot = 0
    ratings.each do |rating|
      tot += rating.score
    end
    (tot.to_f/ratings.count).round(2)
  end

end
