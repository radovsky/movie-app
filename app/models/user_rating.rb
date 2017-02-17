class UserRating < ApplicationRecord
  validates_presence_of :user, :film
  validates_inclusion_of :star_rating, in: 1..5, message: "must be between 1 and 5."

  belongs_to :user
  belongs_to :film
end
