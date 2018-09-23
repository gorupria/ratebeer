module RatingAverage

  def average_rating
    return 0 if ratings.empty?
    tot = 0
    ratings.each do |rating|
      tot += rating.score
    end
    (tot.to_f/ratings.count).round(2)
  end

end
