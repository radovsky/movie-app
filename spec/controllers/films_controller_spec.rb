require "rails_helper"

RSpec.describe FilmsController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code and response body" do
      film = FactoryGirl.create(:film)
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response.body).to eq({ films: [film.as_json_api] }.to_json)
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code and response body" do
      film = FactoryGirl.create(:film)
      get :index, id: film.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response.body).to eq({ films: [film.as_json_api] }.to_json)
    end
  end

  describe "POST rate" do
    it "responds successfully with an HTTP 200 status code and response body" do
      film = FactoryGirl.create(:film)
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)

      expect(UserRating.all.count).to eq(0)
      expect(film.average_rating).to eq(0)

      post :rate, film_id: film.id, user_id: user1.id, star_rating: 3

      expect(UserRating.all.count).to eq(1)

      film.reload
      expect(film.average_rating).to eq(3)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response.body).to eq({ films: [film.as_json_api] }.to_json)

      post :rate, film_id: film.id, user_id: user2.id, star_rating: 4

      expect(UserRating.all.count).to eq(2)

      film.reload
      expect(film.average_rating).to eq(3.5)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response.body).to eq({ films: [film.as_json_api] }.to_json)
    end
  end
end