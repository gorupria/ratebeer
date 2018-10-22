class Rating < ApplicationRecord
  belongs_to :beer, touch: true
  belongs_to :user

  scope :recent, -> { Rating.last(5).reverse }
  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

  def to_s
    return "#{self.beer.name}, #{self.score}"
  end
end
