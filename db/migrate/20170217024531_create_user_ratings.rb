class CreateUserRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :user_ratings do |t|
      t.references :user, index: true
      t.references :film, index: true
      t.integer    :star_rating

      t.timestamps
    end
  end
end
