class User < ApplicationRecord
  include RatingAverage

  has_secure_password
  PASSWORD_FORMAT = /\A
    (?=.*[A-Z])
    (?=.*\d)
    /x

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 }, format: { with: PASSWORD_FORMAT }

  def index
    @users = User.all
  end

  def favorite_beer
    return nil if ratings.empty?
    #ratings.sort_by { |r| r.score }.last.beer
    # if the number of ratings are huge, sorting in the db level improves the performance
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    avg_rating = ratings.map { |rating| rating.beer.average_rating } 
    max_index = avg_rating.index(avg_rating.max)
    
    return ratings[max_index].beer.style.name
  end

  def favorite_brewery
    return nil if ratings.empty?
    avg_rating = ratings.map { |rating| rating.beer.average_rating }
    max_index = avg_rating.index(avg_rating.max)

    return ratings[max_index].beer.brewery.name
  end
end
