class FilmsController < ApplicationController
  # Shortcut for development, never do this in production.
  skip_before_action :verify_authenticity_token, only: :rate

  def index
    films = Film.all #would never send this unfiltered in a production app
    render json: { films: films.map(&:as_json_api) }
  end

  def show
    film = Film.find(params[:id])
    render json: { films: [film.as_json_api] }
  end

  # While it might technically be more RESTful to have this endpoint in a 
  # separate UserRating controller/route, from the perspective of the end user
  # it makes sense to have this under the Film resource.
  def rate
    puts film_rating_params

    film = Film.find(film_rating_params[:film_id])
    user = User.find(film_rating_params[:user_id])

    rating = UserRating.create!(user: user, film: film, star_rating: film_rating_params[:star_rating])

    render json: { films: [film.as_json_api] }
  rescue [ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound] => e
    head 403
  end

  def film_rating_params
    params.permit(:film_id, :star_rating, :user_id)
  end
end
