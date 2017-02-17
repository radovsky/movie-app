class FilmSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :url_slug, :year, :average_rating, :related_film_ids

  def average_rating
    # This works fine for a demo app like this - if we wanted to store average
    # star rating in a production app, we'd run this query on a cron and cache
    # the value, or something else more performant than querying each time.
    ratings = object.user_ratings.map(&:star_rating)
    return 0.0 if ratings.empty?
    (ratings.inject(:+) / ratings.count.to_f).round(2)
  end
end
