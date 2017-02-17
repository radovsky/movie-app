class FilmRelatedFilm < ApplicationRecord
  validates_presence_of :film, :related_film
  validates :film, uniqueness: { scope: :related_film }

  belongs_to :film
  belongs_to :related_film, class_name: 'Film', foreign_key: 'related_film_id'
end
