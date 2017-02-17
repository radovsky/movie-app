class Film < ApplicationRecord
  include ActiveModel::Serialization

  validates_presence_of :title, :description, :url_slug
  validates_inclusion_of :year, in: 1900..(Date.today.year + 1), message: "They weren't making films then..."

  has_many :film_related_films
  has_many :related_films, through: :film_related_films

  has_many :user_ratings

  def average_rating
    # This works fine for a demo app like this - if we wanted to store average
    # star rating in a production app, we'd run this query on a cron and cache
    # the value, or something else more performant than querying each time.
    ratings = user_ratings.map(&:star_rating)
    return 0.0 if ratings.empty?
    (ratings.inject(:+) / ratings.count.to_f).round(2)
  end

  # I'm not that familiar with ActiveModel::Serializers, and am finding it
  # more difficult to get them to work than expected, so I'll construct
  # the JSON response myself for now.
  def as_json_api
    {
      id: id,
      title: title,
      description: description,
      url_slug: url_slug,
      year: year,
      average_rating: average_rating,
      related_film_ids: related_film_ids
    }
  end
end
