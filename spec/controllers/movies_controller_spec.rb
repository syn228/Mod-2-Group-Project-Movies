require 'rails_helper'

RSpec.describe MoviesController do
#   it "returns http success" do
#     movie = Movie.create(name:"The Avengers", genre:"Science Fiction, Action, Adventure", budget:"220000000", producer:"Marvel Studios")
#     get :show, id: movie.id
#     expect(response).to have_http_status(:success)
#   end
# end
  # let(:attributes) do
  # {
  #   name:"The Avengers",
  #   genre:"Science Fiction, Action, Adventure",
  #   budget:"220000000",
  #   producer:"Marvel Studios",
  # }

  # end
  let(:article) {Movie.create!(name:"The Avengers",
    genre:"Science Fiction, Action, Adventure",
    budget:"220000000",
    producer:"Marvel Studios")}
  let(:article_found) { Movie.find(id: article.id)}

  describe "showing a movie" do
    it "shows a movie" do

      get :show, id: article.id
      expect(article_found.id).to eq(article.id)
    end
  end
end
