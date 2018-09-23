class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :beer_club

  validates_uniqueness_of :beer_club_id, scope: :user_id
end
