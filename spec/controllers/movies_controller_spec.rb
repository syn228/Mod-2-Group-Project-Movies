require 'rails_helper'

RSpec.describe MoviesController do
  let(:attributes) do
  {
    name:"The Avengers",
    genre:"Science Fiction, Action, Adventure",
    budget:"220000000",
    producer:"Marvel Studios",
  }
  end
let(:article_found) { Movie.find(@article.id)}

  before do
    @article = Movie.create!(attributes)
  end

  describe "showing a movie" do
    it "shows a movie" do
      get :show, id: @article.id
      expect(article_found).to eq(@article)
    end
  end
end
