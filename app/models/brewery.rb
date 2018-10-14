class Brewery < ApplicationRecord
  include RatingAverage

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil, false] }
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                   less_than_or_equal_to: ->(_brewery) { Date.current.year },
                                   only_integer: true }

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating || 0) }
    return sorted_by_rating_in_desc_order[0..n-1]
  end
  
end
