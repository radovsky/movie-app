class CreateFilmRelatedFilms < ActiveRecord::Migration[5.0]
  def change
    create_table :film_related_films do |t|
      t.integer :film_id
      t.integer :related_film_id

      t.timestamps
    end
  end
end
