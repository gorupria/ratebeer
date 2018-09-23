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
end
