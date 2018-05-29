class GeneralsController < ApplicationController

  def home
  end

  def index
    if params[:search]
      @movies = Movie.search_movies(params[:search])
        @movies.each do |movie|
      Movie.get_movie_info(movie["id"])
      end
    else
      @movies = Movie.all.order("created_at DESC")
    end
  end
end
