class Movie < ApplicationRecord
  has_many :appearances
  has_many :characters, through: :appearances
  has_many :casts
  has_many :actors, through: :casts

  def self.search(search)
  where("name LIKE ? OR genre LIKE ? OR producer LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def self.search_movies(input)
    movie_results = RestClient.get("https://api.themoviedb.org/3/search/movie?api_key=945dbc0976d1fcb4db817690ca47fd3b&language=en-US&query=#{input}&page=1&include_adult=false")

    parsed_movies = JSON.parse(movie_results)
    movie_result = parsed_movies["results"]
    return movie_result
  end

  def self.get_movie_info(input)
    movie = RestClient.get("https://api.themoviedb.org/3/movie/#{input}?api_key=945dbc0976d1fcb4db817690ca47fd3b&language=en-US")
    parsed_movie = JSON.parse(movie)

    movie_title = parsed_movie["title"]
    movie_genre = parsed_movie["genres"].map { |genre| genre["name"] }.join(", ")
    movie_budget = parsed_movie["budget"]
    movie_production = parsed_movie["production_companies"].map {|production| production["name"]}.join(", ")
    Movie.find_or_create_by(name: movie_title, genre: movie_genre, budget: movie_budget, producer: movie_production, api_movie_id: input)
  end

  def get_movie_cast(input)
    cast = RestClient.get("https://api.themoviedb.org/3/movie/#{input}/credits?api_key=945dbc0976d1fcb4db817690ca47fd3b")
    parsed_cast = JSON.parse(cast)
    character_array = []
    actor_array = []
    parsed_cast["cast"].each {|c|
      character_array << c["character"]
      actor_array << c["name"]
    }
    roles = character_array.each_with_index.map {|c, i| "#{c}: #{actor_array[i]}" }
    return roles
  end


end
