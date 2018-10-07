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
end
