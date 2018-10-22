class Style < ApplicationRecord
  has_many :beers
  has_many :ratings, through: :beers

  include RatingAverage

  def self.top(n)
    style = Style.all
    avg = []
    res = [] 
    beer = []
    style.each do |s|
      s.beers.each do |b|
        avg << b.average_rating
        beer[0] = b
      end
      res << [(avg.sum / avg.size.to_f), beer[0].style.name]
      res = res.sort_by { |b| b[0] }
      res = res.reverse.uniq
    end
    return res[0..n-1]
  end
end
