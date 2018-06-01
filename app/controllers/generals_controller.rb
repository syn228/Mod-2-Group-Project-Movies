class GeneralsController < ApplicationController

  def home
  end

  def search

  end

  def index
    if !params[:search].blank?
      @movies = Movie.search_movies(params[:search])
        @movies.each do |movie|
      Movie.get_movie_info(movie["id"])
      end
    else
      @movies = Movie.all.order("created_at DESC")
      redirect_to search_path
    end
  end
end
