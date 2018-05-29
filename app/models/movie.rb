class Movie < ApplicationRecord
  has_many :appearances
  has_many :characters, through: :appearances
  has_many :casts
  has_many :actors, through: :casts

  def search_movies(input)
    movie_results = RestClient.get("https://api.themoviedb.org/3/search/movie?api_key=945dbc0976d1fcb4db817690ca47fd3b&language=en-US&query=#{input}&page=1&include_adult=false")

    parsed_movies = JSON.parse(movie_results)
    parsed_movies["results"].each_with_index { |movies, i|
      "#{i+1}. #{movies["title"]}"
    }

    puts "Please pick movie title by number:"
    input = gets.chomp

    get_movie_info(input)
  end

  def get_movie_info(input)
    movie_id = parsed_movies[(input-1)]["id"]
    movie = RestClient.get("https://api.themoviedb.org/3/movie/#{movie_id}?api_key=945dbc0976d1fcb4db817690ca47fd3b&language=en-US")
    parsed_movie = JSON.parse(movie)

    movie_title = parsed_movie["title"]
    movie_genre = parsed_movie["genres"].map { |genre| genre["name"] }.join(", ")
    movie_budget = parsed_movie["budget"]
    movie_production = parsed_movie["production_companies"].map {|production| production[:name]}.join(", ")
  end

  def get_movie_cast(input)
    movie_id = parsed_movies[(input-1)]["id"]
    cast = RestClient.get("https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=945dbc0976d1fcb4db817690ca47fd3b")
    parsed_cast = JSON.parse(cast)
    character_array = []
    actor_array = []
    parsed_cast["cast"].each {|c|
      character_array << c["character"]
      actor_array << c["name"]
    }
  end


end
