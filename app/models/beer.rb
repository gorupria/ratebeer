class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  belongs_to :style
  has_many :raters, -> { distinct }, through: :ratings, source: :user
  validates :name, presence: true 

  def to_s
    "#{self.name}/#{self.brewery.name}"
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating || 0) }
    return sorted_by_rating_in_desc_order[0..n-1]
  end
end
