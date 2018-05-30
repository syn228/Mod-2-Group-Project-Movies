class GeneralsController < ApplicationController

  def home
  end

  def index
    if params[:search]
      @movies = Movie.search_movies(params[:search])
        @movies.each do |movie|
      Movie.get_movie_info(movie["id"])
      end
      # @movies.each_with_index do |m, i|
      #   if i > 15
      #     sub_array = []
      #     sub_array << @movies[i..-1]
      #   end
      # end
    else
      @movies = Movie.all.order("created_at DESC")
    end
  end
end
